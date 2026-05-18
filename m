Return-Path: <stable+bounces-249368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKDGMttgC2pgGQUAu9opvQ
	(envelope-from <stable+bounces-249368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7868E5727BF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15643302B75F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78238E8B7;
	Mon, 18 May 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAtO3ksr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF838B149;
	Mon, 18 May 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130577; cv=none; b=KbWVD/I7lRxJFQ+fSrn81lTlND8Fci2rmowLmvVaG2aOO0yPoR7IrARYnlQ/W0C7N5a2uoUQSPZF52aTFcE3X8y1HTQUVO065QVco7aKrKClfa2Qc/0q+JchJFUj0aaMEBCf9EY0dN32Kd7twKBG8vk6/t8R3a5I5/M3mLnbrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130577; c=relaxed/simple;
	bh=9xSWq3/p42ZAOBsEQMtxfJEQE/1Guk1SM/niBcloTd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhFF+FyBVB8/pNImzY+wfJFvhXAOmQDDGGjfih1NPvcjmsIcJP/OoJdpLycst7LlF6hzRy1tw5BhFPqRlJhfzo2E0QGh/AqNxsVFUAvGBSv/RVa2q8W9kq8D/v3yx6LSvhTIoXPZkQ5bp1a/MlagY0WZTLgZcswMQ9X8kWuNOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAtO3ksr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BEC2BCB7;
	Mon, 18 May 2026 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779130576;
	bh=9xSWq3/p42ZAOBsEQMtxfJEQE/1Guk1SM/niBcloTd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAtO3ksrzt7DJjrHpNTpug1TB9x9vec33F++NIpJ2TO9rfd7gv4EDSobrmmcE0fIy
	 O3gxjbOPlVdjfHdnTioK5F9u48ds8Biz1rsxVKg1LSSOC52e+85qCTtj+S2dcNRdeW
	 6FKKfd1o/GNCHwA0x2ugS7FfI6MCcnIcmRv2ZEIMMRuBT9YsUt4j3o/fuv8Cdyizaw
	 1S0Ta1gT/NykobMjlRWWKR/MR9ujwgwuAGFvbZUeEm+uIhV1uQ0DyzZj65qaYf8Xtq
	 Ow3X5F+5suIqWaMVYP23JeWSFykQkqeCczX8v6rhxZA9JrfZMQza+ak7eI+DHyFRRu
	 VVQhYETjNxlvw==
Date: Mon, 18 May 2026 19:56:11 +0100
From: Simon Horman <horms@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] iavf: validate num_vsis in
 VIRTCHNL_OP_GET_VF_RESOURCES response
Message-ID: <20260518185611.GF98116@horms.kernel.org>
References: <SYBPR01MB7881AF11C45AEDC0D4CA89C1AF062@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <SYBPR01MB788139F8F31129E4B64E66D4AF072@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB788139F8F31129E4B64E66D4AF072@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249368-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,horms.kernel.org:mid,outlook.com:email]
X-Rspamd-Queue-Id: 7868E5727BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 02:55:04PM +0800, Junrui Luo wrote:
> The VF allocates a fixed-size buffer for IAVF_MAX_VF_VSI (3) VSI
> entries when processing a VIRTCHNL_OP_GET_VF_RESOURCES response from
> the PF. However, num_vsis from the PF response is used unchecked as
> the loop bound when iterating over vsi_res[] in multiple functions.
> 
> A PF sending num_vsis greater than IAVF_MAX_VF_VSI, or the received
> message is shorter than num_vsis claims leads to out-of-bounds accesses
> on the vsi_res[] array.
> 
> Clamp num_vsis based on the actual bytes copied from the PF response.
> 
> Fixes: 5eae00c57f5e ("i40evf: main driver core")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> Changes in v2:
> - Clamp num_vsis based on actual received message length instead of
> IAVF_MAX_VF_VSI suggested by Przemek
> - Link to v1: https://lore.kernel.org/r/SYBPR01MB7881AF11C45AEDC0D4CA89C1AF062@SYBPR01MB7881.ausprd01.prod.outlook.com

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI-generated review of this patchset available on sashiko.dev.
However, I believe that the issues raised there can be considered in
the context of possible follow-up. I do not believe they should block
progress of this patch.

