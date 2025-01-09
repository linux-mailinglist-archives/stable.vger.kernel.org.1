Return-Path: <stable+bounces-108065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB74A07040
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 09:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3CC1649F8
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4D215063;
	Thu,  9 Jan 2025 08:44:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFA206F3E;
	Thu,  9 Jan 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412298; cv=none; b=kickjJGqh/+5ZGdzDblk693ljvF1vhY/Z2SI22COwx8UBBeHGu0bW//NDMiUkmjX5OD1jFV7uEaVo6StHYcFH9HVtJgZGI7vM2M8K/Qz75xNKcalrTutWxo4B0UQA4CF3sQ9QQsv7Rd/hlfIl/zZDFaZaTH/8bX/MmJWcw0I2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412298; c=relaxed/simple;
	bh=lgfLQurGLtjeaYldSEOaJebjxu+yRa+hLOLMPu3NYAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szmj0A1MpMZwnYoKO4aw91ezANymSKITVFIx1eJtNDFTDw29TIS4v/wFJk4ZpAM/gOJnoDpbjxCaFN+sYR8wPj/X7Twn+wZ+zjzbrToPXVGpwrzF2nNznj67Jq/74PSasD243A5YFDfdbKbS7t4vZ6UQNoonnMgZ+7gGNq0UNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f86e47fece6511efa216b1d71e6e1362-20250109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:57925678-e1fd-4d80-bd6c-f9a307b5ac1d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:683a10796791edefd7b00a31c1d4a73a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f86e47fece6511efa216b1d71e6e1362-20250109
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1935724735; Thu, 09 Jan 2025 16:44:42 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 67BA8B80758A;
	Thu,  9 Jan 2025 16:44:42 +0800 (CST)
X-ns-mid: postfix-677F8C7A-207202752
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id 6AF04B80758A;
	Thu,  9 Jan 2025 08:44:40 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Shunsuke Mie <mie@igel.co.jp>
Cc: linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tools: fixed compile tools/virtio error "__user" redefined [-Werror]
Date: Thu,  9 Jan 2025 16:43:41 +0800
Message-Id: <20250109084341.477226-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

we use -Werror now, and warnings break the build so let's fixed it.

from virtio_test.c:17:
./linux/../../../include/linux/compiler_types.h:48: error: "__user" redef=
ined [-Werror]
48 | # define __user BTF_TYPE_TAG(user)
|
In file included from ../../usr/include/linux/stat.h:5,
from /usr/include/x86_64-linux-gnu/bits/statx.h:31,
from /usr/include/x86_64-linux-gnu/sys/stat.h:465,
from virtio_test.c:12:
../include/linux/types.h:56: note: this is the location of the previous d=
efinition
56 | #define __user

Cc: stable@vger.kernel.org

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 include/linux/compiler_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
index 5d6544545658..3316e56140d6 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -54,6 +54,7 @@ static inline void __chk_io_ptr(const volatile void __i=
omem *ptr) { }
 # ifdef STRUCTLEAK_PLUGIN
 #  define __user	__attribute__((user))
 # else
+#  undef __user
 #  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
--=20
2.34.1


