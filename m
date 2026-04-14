Return-Path: <stable+bounces-237923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEKqGwxq3mmxDgAAu9opvQ
	(envelope-from <stable+bounces-237923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:23:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1066C3FC83D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77E283012E57
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA683ED12B;
	Tue, 14 Apr 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="GmH2UP0S"
X-Original-To: stable@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AC2FF160;
	Tue, 14 Apr 2026 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183815; cv=none; b=F1e3110v7wExYSfU75bLCQm0Oz1W7uRcvvioUvzdXcJ3AYjbtMYYsybgTp6XCPAmPZcfkS866NKDNsAdoDF44PUReGZJ2Q9bYlGPUDTeLvhhSEU+jzYIOfrD0aB+XY1r5SRXpHVER43sscZz9Z27zHNQGgecTZhKNmSI3yLDeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183815; c=relaxed/simple;
	bh=6uDb7kejujBqUUB9ZxrJQJb7QoGJK8VBUq9D7VjAZx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHXu/NQKyRHD2CxlLBkkDW33Qadw52ARpI3j8EKAam/sGGfxteZuPfBa3zNi+DvWg5oU7947txl2J9vUwbiAAeBRMFyr/07kaWM5pfW51xIYGCXDnKaI6b4rO8hOgoEeX8wpRAI2t5FOu+nRKZpGa5mRscwA4u35fFaHXmFLS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=GmH2UP0S; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1776183800; bh=A9w41jfbeBcNMsPNcn43GbwXzCi67ge8k9Gp5bHo37k=;
	h=From:Message-ID:From;
	b=GmH2UP0S4F7NTFLQSPWUt+Y5+qVp/NHGAtFg4tdsJhORGacHG5wIrP2H3n0G6qrhA
	 asVFgL6ZDuexsnNfzXdP3DhXk2ZLSPsICUhm0e5W70m+gHbNYdyxlh39Nobyhdma8Y
	 bX+SSXby8ukWX0KhRqRJ4GXrFbxrnkp+CXl7YADs=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 0EAD9C2E94;
	Tue, 14 Apr 2026 18:23:20 +0200 (CEST)
Date: Tue, 14 Apr 2026 18:23:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: pabeni@redhat.com, chandrashekar.devegowda@intel.com,
        linux-wwan@lists.linux.dev, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
Message-ID: <ad5p7XlSOKoaQC5D@1wt.eu>
References: <ad4-bTbjtxbUXDU9@1wt.eu>
 <20260414153201.1633720-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414153201.1633720-1-jhapavitra98@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237923-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,1wt.eu:dkim,1wt.eu:mid]
X-Rspamd-Queue-Id: 1066C3FC83D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Tue, Apr 14, 2026 at 11:31:56AM -0400, Pavitra Jha wrote:
> t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
> a loop bound over port_msg->data[] without checking that the message buffer
> contains sufficient data. A modem sending port_count=65535 in a 12-byte
> buffer triggers a slab-out-of-bounds read of up to 262140 bytes.
> 
> Add a struct_size() check after extracting port_count and before the loop.
> Pass msg_len to t7xx_port_enum_msg_handler() and use it to validate
> the message size before accessing port_msg->data[].
> Pass msg_len from both call sites: skb->len at the DPMAIF path after
> skb_pull(), and the captured rt_feature->data_len at the handshake path.
> 
> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
> Cc: stable@vger.kernel.org
> Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>

Please note that you don't need the Reported-by tag when it's the same
as the Signed-off-by one.

Also, I'm noticing a few empty-line removals out of context below:

> diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> index 7968e208d..d0559fe16 100644
> --- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> +++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> @@ -453,25 +453,25 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
>  {
>  	enum mtk_feature_support_type ft_spt_st, ft_spt_cfg;
>  	struct mtk_runtime_feature *rt_feature;
> +	size_t feat_data_len;
>  	int i, offset;
>  
>  	offset = sizeof(struct feature_query);
>  	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
>  		rt_feature = data + offset;
> -		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
> -
> +		feat_data_len = le32_to_cpu(rt_feature->data_len);
> +		offset += sizeof(*rt_feature) + feat_data_len;
>  		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
>  		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
>  			continue;
> -

here

>  		ft_spt_st = FIELD_GET(FEATURE_MSK, rt_feature->support_info);
>  		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
>  			return -EINVAL;
> -

Here, the original author probably left the line to highlight the return
statement.

> -		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
> -			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
> +		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
> +			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
> +						   feat_data_len);
> +		}
>  	}
> -

Here, why?

>  	return 0;
>  }
>  
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index ae632ef96..d984a688d 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -154,7 +161,6 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
>  
>  	return 0;
>  }
> -

This one as well.

>  static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
>  {
>  	const struct t7xx_port_conf *port_conf = port->port_conf;

Better leave them untouched, it will keep the code as readable as it
previously was and reduce the overall review effort.

thanks,
willy

