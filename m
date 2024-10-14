Return-Path: <stable+bounces-84799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3599D226
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508461C2228F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7611AC8A2;
	Mon, 14 Oct 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WYshq169"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBD1AB505;
	Mon, 14 Oct 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919254; cv=none; b=OcWvtGKeumY6mrK6pze3BornneJgAPvMGG2tdaHOOKOeXOQM9lW8ydw3AjuBUn3SfLygYgXcxUn2TgsG/NbzAUhcdr1u66ghfUqcYjGGkUMuJX68vd4xV57p7Y5mAhYO52VtYzQPTzEIi/QR5nLTUhOb0sjw+zFTBsN1znFDpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919254; c=relaxed/simple;
	bh=ejNKuTIqQaeoMAGZ6W/n1KT5azrAV9gv7b3iRDmiFmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csruuWMNjSm9J93aIBX2Igi5VYSsUMmgIitNg2O03Eklanog23oc3CwdUs9u/YLjhXTXsSSlYJIchQmMESyNahs3byUkGI+gvd+FGUPwDjL1P7Kwy6bi7SvWr/s6bx3WSaxMlEo3UIYYl+GcxbsI+6Ovc6zvwZRg+lMDZ7YbvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WYshq169; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EA6C4CEC7;
	Mon, 14 Oct 2024 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919254;
	bh=ejNKuTIqQaeoMAGZ6W/n1KT5azrAV9gv7b3iRDmiFmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYshq169RrsoajSVb9iZaOrzc2yI4TgCA54QJrBM187Sk2KK/0+66xezeTTJW+ywy
	 H8k9xMgIIobNaEE5WFR4iV7SuNiG37V+NgaJVsAPKf8z6+m02kQkH/Ekqgb+EbxAYl
	 KeJzQDMeNqARMfAjWl6kMSQHwXQF5LIApH7GM98k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.1 556/798] ext4: mark fc as ineligible using an handle in ext4_xattr_set()
Date: Mon, 14 Oct 2024 16:18:30 +0200
Message-ID: <20241014141239.838253345@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Henriques (SUSE) <luis.henriques@linux.dev>

commit 04e6ce8f06d161399e5afde3df5dcfa9455b4952 upstream.

Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may result
in a fast-commit being done before the filesystem is effectively marked as
ineligible.  This patch moves the call to this function so that an handle
can be used.  If a transaction fails to start, then there's not point in
trying to mark the filesystem as ineligible, and an error will eventually be
returned to user-space.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240923104909.18342-3-luis.henriques@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2505,6 +2505,8 @@ retry:
 
 		error = ext4_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
 		error2 = ext4_journal_stop(handle);
 		if (error == -ENOSPC &&
 		    ext4_should_retry_alloc(sb, &retries))
@@ -2512,7 +2514,6 @@ retry:
 		if (error == 0)
 			error = error2;
 	}
-	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
 
 	return error;
 }



