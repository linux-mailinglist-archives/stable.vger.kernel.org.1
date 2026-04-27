Return-Path: <stable+bounces-241427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBqPDM6z72kYEAEAu9opvQ
	(envelope-from <stable+bounces-241427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:06:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD350479045
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C1030416F0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732B13EDAA7;
	Mon, 27 Apr 2026 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3s5gUcv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5F33123F;
	Mon, 27 Apr 2026 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316630; cv=none; b=rTRtKBfntOUMSL0xcHLJog4vzxJAtJ2bNBDk7mUQLhIEYdbUbTbXiv9ou+tcGeEgAWJL7zmH877MMkZUtIDLN225CdL6s8G//ka+QniqMjYLUO4JoVZqSkCHi9hWoFukHY/BXeSQNUq6G+CBlbkWZwQTbqeaBtbE89T0Vl68Krw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316630; c=relaxed/simple;
	bh=kB+for0y6dIBMZVVQYeuy1yMnER1JF0bF8LV+nAwEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqldh7fQX8PnXkFYnWE/gk213lnSU4PJGgL8gvDim4ssmOtF7Be0ROFObeAsCu+HiLSaoxZ/QXeoChb/mBxQDMNu2mTH6C7X56KV+gImuX/N3yhX7zETH9HqNBwgo9JafFKm5W3yRmqoW4eptzQ1p236ELgHUL/I+IXpBjNKukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3s5gUcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C757C19425;
	Mon, 27 Apr 2026 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316629;
	bh=kB+for0y6dIBMZVVQYeuy1yMnER1JF0bF8LV+nAwEZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3s5gUcvYrVMINrtn+7la0LwBBRthlX6D/UJTgpcLaQgHU4tYcmOSuR/f1vJzMR1O
	 u0ILHQN60g3j6plgb5N3XcETjJAYozpD+lO4/qtcR3pXcxqL+Hbn5hsZ/PPWHQm2Td
	 fkUbz7VhH0VuQQHB5ZSSUH0eWAbqeq0KbrtXszpTmDIzHllyPM3bc2s6jUnJU+L/lP
	 Dv076DNiS+sKIRE+rJezDMlwT9hwC2gpIxpvA7YrjerzWWZsY8Hw0Z5ly6XyjN6XWN
	 FteAVuKuRMER7mgWLOlNmlhm7iY0U3cmQYvdf4Sltb3JfNjoeNroxso6vWws5VvVRl
	 ZljeIJiOFwuPQ==
From: Simon Horman <horms@kernel.org>
To: jhapavitra98@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	w@1wt.eu,
	pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Mon, 27 Apr 2026 20:03:24 +0100
Message-ID: <20260427190323.1247342-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423150733.2025838-1-jhapavitra98@gmail.com>
References: <20260423150733.2025838-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD350479045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241427-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

The patch attempts to fix a slab-out-of-bounds read in
t7xx_port_enum_msg_handler() by checking msg_len against struct_size().
It passes msg_len from t7xx_parse_host_rt_data() and control_msg_handler().

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> index 7968e208dd37c..dc90691ef3f54 100644
> --- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> +++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> @@ -453,12 +453,14 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
>  {
>  	enum mtk_feature_support_type ft_spt_st, ft_spt_cfg;
>  	struct mtk_runtime_feature *rt_feature;
> +	size_t feat_data_len;
>  	int i, offset;
>  
>  	offset = sizeof(struct feature_query);
>  	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
>  		rt_feature = data + offset;

The loop condition "offset < data_length" only ensures there is at least 1 byte
remaining in the buffer. Could accessing rt_feature->data_len read out-of-bounds
if data_length - offset is less than sizeof(*rt_feature)?

> -		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
> +		feat_data_len = le32_to_cpu(rt_feature->data_len);
> +		offset += sizeof(*rt_feature) + feat_data_len;

Could adding the 32-bit untrusted feat_data_len to offset cause an integer
overflow since offset is a signed int? If a malicious modem provides a large
value (e.g., 0xFFFFFFF0), offset could become negative, which would keep the
loop condition true and lead to arbitrary backward out-of-bounds reads on the
next iteration.

>  		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
>  		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
> @@ -468,8 +470,10 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
>  		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
>  			return -EINVAL;
>  
> -		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
> -			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
> +		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
> +			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
> +						   feat_data_len);
> +		}

Here, feat_data_len is passed as msg_len, which is extracted directly from the
untrusted modem payload (rt_feature->data_len). Is this length validated against
the actual remaining buffer size (data_length - offset - sizeof(*rt_feature))?

If a malicious modem provides a small physical buffer but a very large data_len
field, the new msg_len bounds check in t7xx_port_enum_msg_handler() could still
pass, defeating the purpose of this patch and allowing the out-of-bounds read to
occur.

>  	}
>  
>  	return 0;
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index ae632ef966983..fa24284448e55 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
[ ... ]
> @@ -141,6 +142,13 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
>  	}
>  
>  	port_count = FIELD_GET(PORT_MSG_PRT_CNT, le32_to_cpu(port_msg->info));

This function reads port_msg->info, port_msg->head_pattern, and
port_msg->tail_pattern before validating msg_len. If the provided msg_len is
smaller than sizeof(struct port_msg) (12 bytes), could these accesses read
out-of-bounds memory?

> +
> +	if (msg_len < struct_size(port_msg, data, port_count)) {
> +		dev_err(dev, "Port enum msg too short: need %zu, have %zu\n",
> +			struct_size(port_msg, data, port_count), msg_len);
> +		return -EINVAL;
> +	}
> +
[ ... ]
> @@ -191,7 +199,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
>  
>  	case CTL_ID_PORT_ENUM:
>  		skb_pull(skb, sizeof(*ctrl_msg_h));

Is the SKB length validated before calling skb_pull()? If skb->len is less than
sizeof(*ctrl_msg_h), skb_pull() fails and leaves the SKB unmodified. Passing the
unpulled skb->data could cause the handler to misinterpret the control header as
the port message payload.

> -		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data);
> +		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
>  		if (!ret)
>  			ret = port_ctl_send_msg_to_md(port, CTL_ID_PORT_ENUM, 0);
>  		else

Does this function leak the skb buffer in the CTL_ID_PORT_ENUM and default
switch cases?

In control_msg_handler(), the skb is explicitly freed using dev_kfree_skb_any()
for CTL_ID_HS2_MSG and CTL_ID_MD_EX*:

drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:control_msg_handler() {
    ...
	switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
	case CTL_ID_HS2_MSG:
        ...
		dev_kfree_skb_any(skb);
		break;

	case CTL_ID_MD_EX:
	case CTL_ID_MD_EX_ACK:
	case CTL_ID_MD_EX_PASS:
	case CTL_ID_DRV_VER_ERROR:
		ret = fsm_ee_message_handler(port, ctl, skb);
		dev_kfree_skb_any(skb);
		break;
    ...
}

However, for CTL_ID_PORT_ENUM and default, the function returns without freeing
the skb, and the caller does not free it either. Could a malicious modem trigger
memory exhaustion by repeatedly sending CTL_ID_PORT_ENUM or invalid control
messages?

