Return-Path: <stable+bounces-200750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AECB411D
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE2D3300A222
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1A26D4F7;
	Wed, 10 Dec 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GLggI3kk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BD1F5851
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402624; cv=none; b=py1h8nUrHuRlRO4k8cuFxDJeruZkXw2ZdINfbJlnxR9KD0ZHiGEU3wVdcN5slOLbHLbTTtk5lEPr9ARNhIegtKR2Nvovi7Z2iZifaA1lBLiZaz71DTFPNuV0fKmmiMgSei9m72bGU3DPN/PynYSEwxtvmBEPBiO9eOgVpbDcXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402624; c=relaxed/simple;
	bh=hM6eAQCt/0ST9NknTRn3Uf9i3zN9DWizNQQDtb1+waE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIhkh/C3/rPxhUPcDb6YYCIX9l635trVNK6oXZV6daAw42HostVAJTXhDu1V8clwLnmuKurnzBeBg+uDzOXkP5ztrP/JVIatfATzqPEepZ0VlD0ftJ2e2qyEjrr8XylcngSaPvGtB/b+nho3IGIjlrwgAhZhgU3DR5bBf6Gbxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GLggI3kk; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so369667a91.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 13:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765402621; x=1766007421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLeHkUExImnvo8Gjruc4Vode6LFSGNd+k+JT5Xq/Lz0=;
        b=PrApVNfpZyav39e7Fbfkv6izUubW/rCICynmcjxEorl66Vf5LMSfS6Iq2uA8JPUIrq
         zIHsEgxCF45Vy9ootbi4TivB9ST3H3tzphFV1S4m+hOf7bjz2aj2STkLS0tkgQm2UTQG
         /LJKjjkRpHQHVxXO7CI49Os9TTVo3x6ESSn9owAUFTbdOeqcVMMlMuJdXViEQNp5iz7C
         VozqetiJD7J7W9dN9nl4rjaJ9tGezHLsd1NqIijF9DUzimRZxAMoUcB5ZRMGZvK+RZ7h
         f/Q1Bx0HwlLyTVrd5oB5lvQW2iVElAosJyPjphJYgWUdZX6JbL/FSS//HOKFGjvTd7Yi
         CpJw==
X-Gm-Message-State: AOJu0YyLeeOg5Wlvce0SmV0/q3SNMLt5eFkdWs1Mmsjfn46AGFm6yR1B
	VOvIK2XzgbOIBmmGOWXWLLl0XjQcxo9rRMJhj1f9HEZVyaJK+KB5B638MLqApMPaNWg8LBMY4Vn
	i54RdTyOywDtwrIMSzyZU1w7kNIPJTrqroA4f/EDgv+WcaNMNh3zllQuAx5miQijgONGY5/4ioh
	Npb5qPR20gzH2zBKkpzpMwcJDbk2nFquTZkPOCASKJ7uoG6TRyXJv8H7uIuY8a6gfMz4zBF2fR+
	uGxli4YNX4mX8O7+w==
X-Gm-Gg: AY/fxX5r8IA0tFSBetYjC918VA9aOFFUQdwp3Qma6iGMcVur7ONuHIZVs0hFXBILMZH
	7usLvaIHwkVPRHfmHu29pQOssRx+kxIQnoSQWh2skaPnKtGmal15igjNOAioPRDZ4WN6SADq2j0
	FHMgDzeMGxu/D8GL2LAZJzhYdbbSvQdyD0EDSU76E58a3NCfRzpZcaRmpd8pDQWphrQuH5+5z3c
	eCGmMt9+RbvkDSgzuVAkI6QToca6B2yRcfZS0C/qmJKc+a+zlIhOvWCmJroauitoD7ICRBvJPoV
	EHHrvqoeTarQXd+baQniABUL8nYBWcu31YBWKRUtV9e5d8nWcwik2esn43T7mvXyK1HNCZydNfo
	zje5zEISZdSeiJ/ve88KV4QO05xgkI7/uCULzwgmWhIstFa0pXCocZZ2uAhJUm5UBC8IawUfeIj
	RVbIq3jKDzHZ62xMixh6tIw2k5OhnYsTj8QoG+6Qfu6prE2d3pzm0=
X-Google-Smtp-Source: AGHT+IE50y2LQqItoFTU8xvX+rOWJrYmwKci+uKqwBoi7by7ryRiHtl0nYWYkspWBibpXKHQHfPDVdy7B60F
X-Received: by 2002:a17:90b:1c04:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-34a7286c42amr3906107a91.13.1765402621425;
        Wed, 10 Dec 2025 13:37:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34a8f8e2d70sm54093a91.3.2025.12.10.13.37.01
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2025 13:37:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so90702385a.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765402620; x=1766007420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLeHkUExImnvo8Gjruc4Vode6LFSGNd+k+JT5Xq/Lz0=;
        b=GLggI3kk5g0s341GGUHvVB00Mr2UbZwULJ/oTA3WXtqStiMeGJxQlpzDcUtqfCxYoB
         fpXMMknWPJYmsvocmh7su6Hoczm1JNI63QfR/vkn62osfMLBDUF+CgvGM5Tf2LfOLht2
         7VBX4SCsi43SajLzbJYnDUl4FyAE5TTlJA9gA=
X-Received: by 2002:a05:620a:3196:b0:8b2:eae0:bc02 with SMTP id af79cd13be357-8ba39f5867emr633368485a.88.1765402619779;
        Wed, 10 Dec 2025 13:36:59 -0800 (PST)
X-Received: by 2002:a05:620a:3196:b0:8b2:eae0:bc02 with SMTP id af79cd13be357-8ba39f5867emr633363885a.88.1765402619230;
        Wed, 10 Dec 2025 13:36:59 -0800 (PST)
Received: from photon-blam.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3be05sm49243985a.30.2025.12.10.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:36:58 -0800 (PST)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: stable@vger.kernel.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kees Cook <keescook@chromium.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Subject: [PATCH v5.10] net/mlx5e: Avoid field-overflowing memcpy()
Date: Wed, 10 Dec 2025 21:16:33 +0000
Message-ID: <20251210211633.634693-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <164396387123045@kroah.com>
References: <164396387123045@kroah.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kees Cook <keescook@chromium.org>

commit ad5185735f7dab342fdd0dd41044da4c9ccfef67 upstream.

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use flexible arrays instead of zero-element arrays (which look like they
are always overflowing) and split the cross-field memcpy() into two halves
that can be appropriately bounds-checked by the compiler.

We were doing:

	#define ETH_HLEN  14
	#define VLAN_HLEN  4
	...
	#define MLX5E_XDP_MIN_INLINE (ETH_HLEN + VLAN_HLEN)
	...
        struct mlx5e_tx_wqe      *wqe  = mlx5_wq_cyc_get_wqe(wq, pi);
	...
        struct mlx5_wqe_eth_seg  *eseg = &wqe->eth;
        struct mlx5_wqe_data_seg *dseg = wqe->data;
	...
	memcpy(eseg->inline_hdr.start, xdptxd->data, MLX5E_XDP_MIN_INLINE);

target is wqe->eth.inline_hdr.start (which the compiler sees as being
2 bytes in size), but copying 18, intending to write across start
(really vlan_tci, 2 bytes). The remaining 16 bytes get written into
wqe->data[0], covering byte_count (4 bytes), lkey (4 bytes), and addr
(8 bytes).

struct mlx5e_tx_wqe {
        struct mlx5_wqe_ctrl_seg   ctrl;                 /*     0    16 */
        struct mlx5_wqe_eth_seg    eth;                  /*    16    16 */
        struct mlx5_wqe_data_seg   data[];               /*    32     0 */

        /* size: 32, cachelines: 1, members: 3 */
        /* last cacheline: 32 bytes */
};

struct mlx5_wqe_eth_seg {
        u8                         swp_outer_l4_offset;  /*     0     1 */
        u8                         swp_outer_l3_offset;  /*     1     1 */
        u8                         swp_inner_l4_offset;  /*     2     1 */
        u8                         swp_inner_l3_offset;  /*     3     1 */
        u8                         cs_flags;             /*     4     1 */
        u8                         swp_flags;            /*     5     1 */
        __be16                     mss;                  /*     6     2 */
        __be32                     flow_table_metadata;  /*     8     4 */
        union {
                struct {
                        __be16     sz;                   /*    12     2 */
                        u8         start[2];             /*    14     2 */
                } inline_hdr;                            /*    12     4 */
                struct {
                        __be16     type;                 /*    12     2 */
                        __be16     vlan_tci;             /*    14     2 */
                } insert;                                /*    12     4 */
                __be32             trailer;              /*    12     4 */
        };                                               /*    12     4 */

        /* size: 16, cachelines: 1, members: 9 */
        /* last cacheline: 16 bytes */
};

struct mlx5_wqe_data_seg {
        __be32                     byte_count;           /*     0     4 */
        __be32                     lkey;                 /*     4     4 */
        __be64                     addr;                 /*     8     8 */

        /* size: 16, cachelines: 1, members: 3 */
        /* last cacheline: 16 bytes */
};

So, split the memcpy() so the compiler can reason about the buffer
sizes.

"pahole" shows no size nor member offset changes to struct mlx5e_tx_wqe
nor struct mlx5e_umr_wqe. "objdump -d" shows no meaningful object
code changes (i.e. only source line number induced differences and
optimizations).

Fixes: b5503b994ed5 ("net/mlx5e: XDP TX forwarding support")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Brennan : Applied to v5.10, convert inline_mtts to flex array (not in union) ]
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h     | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b0229ceae..f41dc9bb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -199,7 +199,7 @@ static inline int mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
 struct mlx5e_tx_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_eth_seg  eth;
-	struct mlx5_wqe_data_seg data[0];
+	struct mlx5_wqe_data_seg data[];
 };

 struct mlx5e_rx_wqe_ll {
@@ -215,7 +215,7 @@ struct mlx5e_umr_wqe {
 	struct mlx5_wqe_ctrl_seg       ctrl;
 	struct mlx5_wqe_umr_ctrl_seg   uctrl;
 	struct mlx5_mkey_seg           mkc;
-	struct mlx5_mtt                inline_mtts[0];
+	struct mlx5_mtt                inline_mtts[];
 };

 extern const char mlx5e_self_tests[][ETH_GSTRING_LEN];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index ae90d533a..923e10d06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -341,8 +341,10 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,

 	/* copy the inline part if required */
 	if (sq->min_inline_mode != MLX5_INLINE_MODE_NONE) {
-		memcpy(eseg->inline_hdr.start, xdptxd->data, MLX5E_XDP_MIN_INLINE);
+		memcpy(eseg->inline_hdr.start, xdptxd->data, sizeof(eseg->inline_hdr.start));
 		eseg->inline_hdr.sz = cpu_to_be16(MLX5E_XDP_MIN_INLINE);
+		memcpy(dseg, xdptxd->data + sizeof(eseg->inline_hdr.start),
+		       MLX5E_XDP_MIN_INLINE - sizeof(eseg->inline_hdr.start));
 		dma_len  -= MLX5E_XDP_MIN_INLINE;
 		dma_addr += MLX5E_XDP_MIN_INLINE;
 		dseg++;
--
2.43.7


