Return-Path: <stable+bounces-4431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB34804774
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9D51F21400
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930AD79F2;
	Tue,  5 Dec 2023 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXj/XUdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B66FB1;
	Tue,  5 Dec 2023 03:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF52C433C7;
	Tue,  5 Dec 2023 03:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747527;
	bh=rg/N7uddibuBV99XCogmri7GTj+Kr+jAr3e43OwGcH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXj/XUdlzfnJHLQ9ctMIrG4UsIaorBzVty9g8muxut9wEfDYa6qIo2bOEEkOiwkBC
	 Uk6JCa1a7HXw9U3p6GorlFLseDXWrJrDllC0JsR60LDaixGD9+wL9IloersNCsWUpX
	 jnX3bv8ns7yeu3vspxakCLhh1Uy5AuxmL8xudH5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.10 085/135] btrfs: fix off-by-one when checking chunk map includes logical address
Date: Tue,  5 Dec 2023 12:16:46 +0900
Message-ID: <20231205031535.921435126@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 5fba5a571858ce2d787fdaf55814e42725bfa895 upstream.

At btrfs_get_chunk_map() we get the extent map for the chunk that contains
the given logical address stored in the 'logical' argument. Then we do
sanity checks to verify the extent map contains the logical address. One
of these checks verifies if the extent map covers a range with an end
offset behind the target logical address - however this check has an
off-by-one error since it will consider an extent map whose start offset
plus its length matches the target logical address as inclusive, while
the fact is that the last byte it covers is behind the target logical
address (by 1).

So fix this condition by using '<=' rather than '<' when comparing the
extent map's "start + length" against the target logical address.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2998,7 +2998,7 @@ struct extent_map *btrfs_get_chunk_map(s
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
 			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
 			   logical, length, em->start, em->start + em->len);



