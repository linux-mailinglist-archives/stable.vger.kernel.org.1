Return-Path: <stable+bounces-81540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B799431D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670981C247F9
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D01DE8AE;
	Tue,  8 Oct 2024 08:52:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9390B676;
	Tue,  8 Oct 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377556; cv=none; b=syqTphDhT+zVNLEPMCJosZT8JG8/kC6hg1dWY+Blo6s4VYZFHMRSzC8TNfrxBWppaMwvFiwjBlKd4yLzTH+M/O5tNkYXGLCFEixzeWcO18jy0yi0c5ZjjxLj7HRkGvimKmyqRBJCuUKaT/+N2Pppq506IU0WFXMzo+g1Pz/BFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377556; c=relaxed/simple;
	bh=n+zxL5iWz/IGGhhcSvf6ZdjqtM/SK+eHp4MhiHCMFnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NElOZTkEK5FejkHnE/nAY1QLbE9A0pmQT4q0g6qjfVEyvXOmpXkIGNmoW89FYe5Gyz7N2K4XmH8X5KIMD+nAhIWFtSHdmR9PRFl9JhVIITrki5PgWced8RV3rnsJneEMJXaECyEcAJjJMVlwWawuSxS0wE6MgLQmJMXex2ZVEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: George Rurikov <g.ryurikov@securitycode.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: George Ryurikov <g.ryurikov@securitycode.ru>, Anton Altaparmakov
	<anton@tuxera.com>, <linux-ntfs-dev@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Danila
 Chernetsov" <listdansp@mail.ru>, Namjae Jeon <linkinjeon@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.10] ntfs: do not dereference a null ctx on error
Date: Tue, 8 Oct 2024 11:52:01 +0300
Message-ID: <20241008085201.2209609-1-g.ryurikov@securitycode.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: MSK-EX1.Securitycode.ru (172.17.8.91) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

From: George Ryurikov <g.ryurikov@securitycode.ru>

Danila Chernetsov <listdansp@mail.ru>

commit aa4b92c5234878d55da96d387ea4d3695ca5e4ab upstream.

In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
'ctx' pointer in error handling.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: George Ryurikov <g.ryurikov@securitycode.ru>
---
 fs/ntfs/mft.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 0d62cd5bb7f8..3feb218174fa 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1955,36 +1955,38 @@ static int ntfs_mft_data_extend_allocation_nolock(n=
tfs_volume *vol)
                                "attribute.%s", es);
                NVolSetErrors(vol);
        }
-       a =3D ctx->attr;
+
        if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
                ntfs_error(vol->sb, "Failed to truncate mft data attribute =
"
                                "runlist.%s", es);
                NVolSetErrors(vol);
        }
-       if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
-               if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+       if (ctx) {
+               a =3D ctx->attr;
+               if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
+                       if (ntfs_mapping_pairs_build(vol, (u8 *)a + le16_to=
_cpu(
                                a->data.non_resident.mapping_pairs_offset),
                                old_alen - le16_to_cpu(
-                               a->data.non_resident.mapping_pairs_offset),
+                                       a->data.non_resident.mapping_pairs_=
offset),
                                rl2, ll, -1, NULL)) {
-                       ntfs_error(vol->sb, "Failed to restore mapping pair=
s "
+                               ntfs_error(vol->sb, "Failed to restore mapp=
ing pairs "
                                        "array.%s", es);
-                       NVolSetErrors(vol);
-               }
-               if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
-                       ntfs_error(vol->sb, "Failed to restore attribute "
+                               NVolSetErrors(vol);
+                       }
+                       if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)=
) {
+                               ntfs_error(vol->sb, "Failed to restore attr=
ibute "
                                        "record.%s", es);
+                               NVolSetErrors(vol);
+                       }
+                       flush_dcache_mft_record_page(ctx->ntfs_ino);
+                       mark_mft_record_dirty(ctx->ntfs_ino);
+               } else if (IS_ERR(ctx->mrec)) {
+                       ntfs_error(vol->sb, "Failed to restore attribute se=
arch "
+                               "context.%s", es);
                        NVolSetErrors(vol);
                }
-               flush_dcache_mft_record_page(ctx->ntfs_ino);
-               mark_mft_record_dirty(ctx->ntfs_ino);
-       } else if (IS_ERR(ctx->mrec)) {
-               ntfs_error(vol->sb, "Failed to restore attribute search "
-                               "context.%s", es);
-               NVolSetErrors(vol);
-       }
-       if (ctx)
                ntfs_attr_put_search_ctx(ctx);
+       }
        if (!IS_ERR(mrec))
                unmap_mft_record(mft_ni);
        up_write(&mft_ni->runlist.lock);
--
2.34.1

=D0=97=D0=B0=D1=8F=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BE =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8

=D0=94=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =D0=B8 =
=D0=BB=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BA =D0=BD=D0=B5=D0=BC=D1=83 =D1=8F=D0=B2=D0=BB=D1=8F=
=D1=8E=D1=82=D1=81=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=
=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D1=8B =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =
=D0=B4=D0=BB=D1=8F =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=B0. =D0=95=
=D1=81=D0=BB=D0=B8 =D0=92=D1=8B =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=
=D1=82=D0=B5=D1=81=D1=8C =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=BE=
=D0=BC =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0,=
 =D1=83=D0=B2=D0=B5=D0=B4=D0=BE=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5=D0=BC=
=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE =D0=BE=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=80=D0=B0=D1=81=D0=BA=
=D1=80=D1=8B=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=
=D0=B6=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BB=
=D0=B8=D1=86=D0=B0=D0=BC, =D0=BD=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=BA=D0=B0=D0=BA=
=D0=B8=D1=85-=D0=BB=D0=B8=D0=B1=D0=BE =D1=86=D0=B5=D0=BB=D1=8F=D1=85, =D0=
=BD=D0=B5 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BD=D0=B5 =
=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D1=83=D0=B9=D1=82=D0=B5 =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BB=D1=8E=D0=B1=D1=8B=D0=BC =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BE=D0=BC.

