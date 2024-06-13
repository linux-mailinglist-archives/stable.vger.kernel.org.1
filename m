Return-Path: <stable+bounces-51897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB3907236
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AB6B23137
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EC143759;
	Thu, 13 Jun 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+FzJFu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5F142E9C;
	Thu, 13 Jun 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282637; cv=none; b=ccWbeC4/dm3ACIqc/DKU8at5e+I9zSo2CQ+fOFmBTBrQ+KaleiIALwijno3qMGzb+VCn17Vbiv/8XMVoF2/6WoCzpbY+rJ+tObW8LrDP7EJsq/4vgq5r/Zn45xLLbUWxDZSclGoZl2/lid0ekieh7IYqfb+9n1OaCj0rzR3WqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282637; c=relaxed/simple;
	bh=zcGNALwnVIXrrJKLsV8GGaSo3u6SKftm+ilkomPAnfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am9/oBj9ooYNmuZ2nOGINVR6d0hGfa9RAs41J1DfA7+ogGjKHib4xhqwWQI9Bqto4JIfaJOdtGVZjrc2jOM5yIH40qBFXl0VIRIvYTzc0rLNVRAK0uvGXQh5HLzZJXPEhbbn2GHWeiWY/VjTmNxDOM94c9x2Fey3uDgRAre6BkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+FzJFu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5C8C4AF1D;
	Thu, 13 Jun 2024 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282637;
	bh=zcGNALwnVIXrrJKLsV8GGaSo3u6SKftm+ilkomPAnfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+FzJFu4M9D08E8gPRoJMsjkU9NQEqx0fVquNagEul0orCSqozQhAsSfAl7tSyy8u
	 jdwoi2izUWhFs1xeZHk2K5QpxXswpNvkWRB8b3T3tjXYSPhb9WZAXIUaOYPWeN8/RO
	 m+yscVmGCM9cNS9v2yPkrJSwIEPwN/Q6L+ZX9Ylg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 344/402] afs: Dont cross .backup mountpoint from backup volume
Date: Thu, 13 Jun 2024 13:35:01 +0200
Message-ID: <20240613113315.550730770@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Dionne <marc.dionne@auristor.com>

commit 29be9100aca2915fab54b5693309bc42956542e5 upstream.

Don't cross a mountpoint that explicitly specifies a backup volume
(target is <vol>.backup) when starting from a backup volume.

It it not uncommon to mount a volume's backup directly in the volume
itself.  This can cause tools that are not paying attention to get
into a loop mounting the volume onto itself as they attempt to
traverse the tree, leading to a variety of problems.

This doesn't prevent the general case of loops in a sequence of
mountpoints, but addresses a common special case in the same way
as other afs clients.

Reported-by: Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>
Link: http://lists.infradead.org/pipermail/linux-afs/2024-May/008454.html
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: http://lists.infradead.org/pipermail/linux-afs/2024-February/008074.html
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/768760.1716567475@warthog.procyon.org.uk
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/mntpt.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -146,6 +146,11 @@ static int afs_mntpt_set_params(struct f
 		put_page(page);
 		if (ret < 0)
 			return ret;
+
+		/* Don't cross a backup volume mountpoint from a backup volume */
+		if (src_as->volume && src_as->volume->type == AFSVL_BACKVOL &&
+		    ctx->type == AFSVL_BACKVOL)
+			return -ENODEV;
 	}
 
 	return 0;



