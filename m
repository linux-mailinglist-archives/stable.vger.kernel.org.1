Return-Path: <stable+bounces-239962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHzdKIxr5mmBwAEAu9opvQ
	(envelope-from <stable+bounces-239962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:08:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEE4327F0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 049BC316D927
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD33A1E73;
	Mon, 20 Apr 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+/d1ek0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38039FCA6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705527; cv=none; b=WRTTw073ZtF9tAxfYAbecu6Dp3JNAG9EdbKw7J3Db1YGpJGwsl+HHSYtdhVa1qk74LUemiQrLocqwMA/irSLeOBl9vbOt1OnDEYLE8gqX0y78hpam3L16ZwGfVzIoaOG2eNwhdw88vKBEkDOI7+tfrIGa/JzDW9ouJg8XO6en8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705527; c=relaxed/simple;
	bh=8O3b3Qe7OMgCHoNg+DiP0hK3ss+m+yydWKT5V3D/PVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kB7B6nDMWxeq6E/xLjk8ppgwsL51Rmf7Buy+ppcr+u16levoWCt1VdeuBHLAKLDmJhVfViSuYhC4gWSy7mBKWJo45FkFjgMdfnyao6kZpBr6lRagk31U3oYvugx7OCmAz47cfZfxGC23O+zviw2Zj87xZwwvVyjRcj9XkEuS70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+/d1ek0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso4424125a91.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705526; x=1777310326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Wff/1M87WllLQ253qBp/0GFiYpAWG5OoBPum9csgI=;
        b=s+/d1ek0eYWKyo9FlOJl6eodJwXQY176qnv47efPy9x8rtd0/whgzHB0FRj8nATz9J
         CHbokX4bCrDScuJSQxO/WS6XEga6DuoVVqT1qIGdnhuytXsyhYyL5mOvxyidrgY47KvY
         axyG3P4d9aCdFDaRi8iHLirIssUoewM3IRQBzQITiMVP/tBWKuZrFzNzXZvQ9QvhKahO
         Q5UU8YLvE2c1q4CedpiaPk86Zhizn/vmGxe2g751E45OVaY2iO/AS20lwEBgbhW1SbNa
         prOcZaRow0kWLvSFGiLk1dPKG1yq9f1omZI3QK8owZu5HzZqkwSZlfNL+Tk7T0UQOFAJ
         TMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705526; x=1777310326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Wff/1M87WllLQ253qBp/0GFiYpAWG5OoBPum9csgI=;
        b=P0QWejb3rVMChpYzmGDNjyc+bTf/WwIEFo1o2mEMgzQ65P+d0dbUXLgGDL2D9B2/EX
         jibDTLQeyzkQuvsAfHQCmLpEh0hJ30GGFEZPpeh7imOmeiJkAOVYPeStxYUtlUS0fLZU
         UFdo5tWm43jpinyZfRDIFSkU3FmaRElJCnhISTP5ju3UkMDlF9LpvQW3tdFekGBIp9AW
         NgrX2PFympEldL+rJ7Nfcr/Qc96smrQYOfNB3a9VXOL9U2Yi/B+OHd+vqfAhTeQxyLhg
         F62JBypARhgcmqWnWZArdRp0njEijYE24ZC9uRMzJkvfYfRRkF7xoNsv+E8B29Fvx6E6
         bEhw==
X-Forwarded-Encrypted: i=1; AFNElJ9jm/uYuqsTuEbjSbFflyUUK6GJG97TR+bwxCABSL9bBOw/xfUFkFOjqzFbFwanUwpyZtvFe+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOvOYz7nXChqemzlIwp2BMK8dafQG0eDPMDv8s3zDynRz8Lfr
	S8RJDvDvFRG5+kcslzzRoXn2/C4plA9i1zA0RaYQ8BeaS/hheGrI72bI2lUyiCj1LXOIAeJ38Cf
	rig2pzaI6U82FjSzKc6xmBSWcPg==
X-Received: from pjbge22.prod.google.com ([2002:a17:90b:e16:b0:35e:4617:916b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e704:b0:35b:9896:cbcd with SMTP id 98e67ed59e1d1-361404b9b70mr13958806a91.27.1776705525487;
 Mon, 20 Apr 2026 10:18:45 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:36 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-4-hramamurthy@google.com>
Subject: [PATCH net 3/4] gve: Use default min ring size when device option
 values are 0
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADAEE4327F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pin-yen Lin <treapking@google.com>

On gvnic devices that support reporting minimum ring sizes, the device
option always includes the min_(rx|tx)_ring_size fields, and the values
will be 0 if they are not configured to be exposed. This makes the
driver allow unexpected small ring size configurations from the
userspace.

Use the default ring size in the driver if the min ring sizes from the
device option are 0.

This was discovered by drivers/net/ring_reconfig.py selftest.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b72cc0fa2ba2..57d898f6fa82 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.54.0.rc0.605.g598a273b03-goog


