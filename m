Return-Path: <stable+bounces-86346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14AD99ED63
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746872867B7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5381B21B8;
	Tue, 15 Oct 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLeRMRRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9181C4A04;
	Tue, 15 Oct 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998603; cv=none; b=SUq6Xs/H2Vv6mfsgaNZt7rbjF5Zf2VEUja+cuu7SW6LfFnLTuXgQTVWdEq3dII/kySTjk7SPbTyUWDHiiI2l7EpAZSq8qMUtubvDinuTiO1/9rrpx9nSXwq6QRwZ+t6ObMIcZ5Sa2KfyXD+9N9V+ZnhgiJmjD1r2RBpexs7DGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998603; c=relaxed/simple;
	bh=tuLuCB9nZuHZmXC0O4b4C3RBIsW64wPWIZBMfMq8/Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uga9dHuK20KKPJ6kbdR7ooBX2WkExErgIzWPIBMsYgrPEObHxI0b7dyIPU/G0jrIRUPMbmM89vi5yQq8YUxs+IaCyb1v7aEikX0JlYm5YWbYV0faQAnZ/EBPMMK7myVo0T8sn64JprangpgbXaY2aFb4ZBJfvP+RlxEprknMZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WLeRMRRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFA5C4CEC6;
	Tue, 15 Oct 2024 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998602;
	bh=tuLuCB9nZuHZmXC0O4b4C3RBIsW64wPWIZBMfMq8/Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLeRMRROC8kZlTo7sVxNOdeqOrLZN8GJZi3cElnmWLz4uxp3CDGs+2pbc1qnImJHD
	 romUQu1xMLigLh/1CJ9GbZ83eOP8Z90kxmZzBzC0iFrzR5K8eYjMITphJGCXrHguyV
	 sHDvCcYIhRCaiFAZYpFB7Lpsg2lQfiU5EMuHbCVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.10 512/518] xfrm: Pass flowi_oif or l3mdev as oif to xfrm_dst_lookup
Date: Tue, 15 Oct 2024 14:46:56 +0200
Message-ID: <20241015123936.751681790@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

From: David Ahern <dsahern@kernel.org>

commit 748b82c23e25310fec54e1eff2cb63936f391b24 upstream.

The commit referenced in the Fixes tag no longer changes the
flow oif to the l3mdev ifindex. A xfrm use case was expecting
the flowi_oif to be the VRF if relevant and the change broke
that test. Update xfrm_bundle_create to pass oif if set and any
potential flowi_l3mdev if oif is not set.

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_policy.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2595,12 +2595,14 @@ static struct dst_entry *xfrm_bundle_cre
 
 		if (xfrm[i]->props.mode != XFRM_MODE_TRANSPORT) {
 			__u32 mark = 0;
+			int oif;
 
 			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
 				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
 			family = xfrm[i]->props.family;
-			dst = xfrm_dst_lookup(xfrm[i], tos, fl->flowi_oif,
+			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
+			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
 					      &saddr, &daddr, family, mark);
 			err = PTR_ERR(dst);
 			if (IS_ERR(dst))



