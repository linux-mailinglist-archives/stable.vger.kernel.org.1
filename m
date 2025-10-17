Return-Path: <stable+bounces-187212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EBBEA107
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7140A1896676
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCAA330B1F;
	Fri, 17 Oct 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HEdNlIHB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE9330B2C;
	Fri, 17 Oct 2025 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715433; cv=none; b=dJB6uroIP9Gi716tTFnqO0OnCCh6TEYFgqkp5Oocj56fj4yhmKWxSyPNY6qKbEN5dCwFiilfTYXtyh5hAkrApo/3BFEufzBySLGVdOu18OqF+SlZwiZ2GggACWIflyk0q9BlEl/SpVhO6ZrO1SSSy7eYy2UJmN+VTLvdB2mgK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715433; c=relaxed/simple;
	bh=sYk3+N2MFqYTa0WYMfyzgnRz+leoYQIcAciH2CYRwn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GebFrGcEq15Q1q7K10N6ykrNUQeOxOkw6ZZb8jTaTUP7jXEgmAJl9bfaFO3oMTTECUT5s28CAWbA8ROT6OVHIis1T5HSgj3VWHDcFTcUTed7NNjX1zpMSJacKYFc65LahhyqPGxZimE72PmbfZ9BESjiYahj8bkP43D8BS/77zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HEdNlIHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386D3C4CEE7;
	Fri, 17 Oct 2025 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715432;
	bh=sYk3+N2MFqYTa0WYMfyzgnRz+leoYQIcAciH2CYRwn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEdNlIHBBTpwINPdFc6wr5DK1YvNm+/+DSJA+TRyBce4RJCZDNYhRdgdmsasJ29ct
	 PllwXoyKEnq+8CzglynxRnXAO6t1E68XtRkv+No69U9Ebvc/ht4AffH9Wst70EeCwY
	 0qynMkY9JHPn1+dalUt/teQh3o57pJqTiw6IIDm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.17 215/371] fuse: fix possibly missing fuse_copy_finish() call in fuse_notify()
Date: Fri, 17 Oct 2025 16:53:10 +0200
Message-ID: <20251017145209.864773733@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 0b563aad1c0a05dc7d123f68a9f82f79de206dad upstream.

In case of FUSE_NOTIFY_RESEND and FUSE_NOTIFY_INC_EPOCH fuse_copy_finish()
isn't called.

Fix by always calling fuse_copy_finish() after fuse_notify().  It's a no-op
if called a second time.

Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
Fixes: 2396356a945b ("fuse: add more control over cache invalidation behaviour")
Cc: <stable@vger.kernel.org> # v6.9
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2156,7 +2156,7 @@ static ssize_t fuse_dev_do_write(struct
 	 */
 	if (!oh.unique) {
 		err = fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs);
-		goto out;
+		goto copy_finish;
 	}
 
 	err = -EINVAL;



