Return-Path: <stable+bounces-246671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNpGNmGSA2pm7gEAu9opvQ
	(envelope-from <stable+bounces-246671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:49:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1BB529906
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854EC30A33DF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB73BF672;
	Tue, 12 May 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piKUebGO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDF3B2FD0
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618596; cv=none; b=VYvz22eMrAlPZ+dH5qo1qtNryn3JgoXSDaq6T5RGVLHOESl8OCzalD8/s4MB+Ck5qgmaYYRL6OdFAhWC3XxSFOaimEYQmH9O6pPSAsecjwZhleBWbErExGqGf6Amhe5IKSyIiwwrntrR2IdHgDR3bWl+iASutt7Ykkrug8bAQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618596; c=relaxed/simple;
	bh=kg4NlVLFvpcet+/cj6Ad8BEvgEVUqQ5ua+TsGgeN3Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUxZXf5n/AcYP2cxFGT09HHYkkv2txYDXxtuJ5XJx0EHiF+PXN3wxY2HuAanAYIVAqKKmuOXGH1hn4jmviGkxaaEtQdsGjMQULM/HfUbmWcmjgP6X/+sjVG/cYSkKqKBXNjD7BSGHbzzs3zFYwhLLtzPlWO00ewmWMb5EhvJS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piKUebGO; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso6788083eec.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778618595; x=1779223395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9lR0A9k7VO7RFKQ4e5f3LHHZHyRUjtt/Q+YXL4+DFc=;
        b=piKUebGOc731XNr2bYOwNguBpq/7zZ1Zf+vxHAvGN4SB3sdKf7NiShUdpWoBUWSw67
         6LT8589bjH+bVhTKsj6KQS+WFSEytdgNjnfdNZKzvkPGIqpL9Pc6q6jCzvUUZVgh5PkO
         OTWXVYj53gaNmgaQLz70W9E5bGDjoTjxInKq8hcDsGZWH8Q8szmdzH5iD5clp0MUBWnc
         3ENTK89bSzZ8JFOKaCsfJJDv8h3wFseWbgvEynMRMMZ2+LvFnssp6lzF/VeGoPg8ZYXp
         IOirUzi1nv/24RPWd21nQsQMT8Dm8DiogIDSFmoQDzsj5le4LYjqzL8GxU1/y29cu4zh
         rlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618595; x=1779223395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9lR0A9k7VO7RFKQ4e5f3LHHZHyRUjtt/Q+YXL4+DFc=;
        b=URDi1fUJbGdXZfxjgnhXa2oGhG40mU9xsTCn8Lk/yNM5qC9Bm3GYwNzFk43I/r3zxy
         rv6sTrvKXdZ2fixSBLbvc/Utz1041cL25xt5IlsJCcyVAAPVSCz6jDdODJEp1tkld7F5
         atvkV0M4LXtDFLcNVjFtUC8SJBWOd2DCsOqqzNEEQhwbMo0CdOIiBiz6ueF/UjGmvCRJ
         1LfX7dkPz6o+ey5q+hQdKvwit5bPQUN2fp5t2epMtMkbcnhlTSzhLIEBc1HNGVPPKS6V
         //ZDvANmXkefpizAsAiEGSGbS8FaKaieR9x1OOx210ra7zhevPn0imWeOVZ455Nme5Im
         hlcg==
X-Forwarded-Encrypted: i=1; AFNElJ9xhtDCLh672yHbHhZG0n9FArNkc6CDZYOho+TkYDI8WEyibBCjQG0JUe81WB2Jc0E0yTFJF4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaJLuUzXrCkxIUOMk+gFimJ7Gaa3+1Nq90Z3oYRwZZXn9UkPi
	KS8rTNQ/K4P5pPMx/qNbKmqG6eFo5CO483NO5zwmE9zpoZNvd44DUmuPYI4fWQLGpLi7WZ0zSTw
	0wq7Hvnvy
X-Gm-Gg: Acq92OGv91ZmQbqaXVdIblV1MCYtTrHm+7Xk6+fkln3b566hK+3IYht6MsRdSGsvcEm
	tCC8CCQGQGrgon7UlQaAOyu3IclAKQ9cA2CAsRKEE3xbTButThnKwi8wsDj6HNtQ0lXxsD2weCp
	XiTG9yRX7qaRRYuSMRpjj6WaAaj/VOYThVCx0gJgeumu9vAaKTmpQxoTUhMgGwCZwF/eSLY9KgC
	Y7BlhQMdnTbfwwL+cqn5nxzmIEvWjQb3gxkFqXY4bpiAslGtPMGsew23+D5ojtXn9RZ5ug8i7td
	U94/r4bIN8rdC0XsUeVMkp5XqZ8bgY5hQYPo5P7MMurUqADpxevz6MIApm2i1Eb+S/bveOhk/1i
	bqWn5oamv7OqkGa/xpBMTaxX/5m+KmRbZU9plQy76k3gUbLMTHowwgpx0rNlF2EqqC5kklbkU7d
	l9g99Dvh1LRf0v2Pg5QwtYGG6w1pCXvXvbom6VvWRagSdiHTNK4ZGNe4wmJZ8PI5U971c52RTCE
	YtaNe8GuFRftM7gKYB9KYhcZEdDWJvbfbE0
X-Received: by 2002:a05:7301:6783:b0:2de:aafb:feff with SMTP id 5a478bee46e88-30117c73cddmr372091eec.2.1778618593919;
        Tue, 12 May 2026 13:43:13 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:839b:f905:79b7:838f? ([2a00:79e0:2e7c:8:839b:f905:79b7:838f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm24437991eec.4.2026.05.12.13.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:43:13 -0700 (PDT)
Message-ID: <4b812fea-fd3f-45e0-a377-3ded43fba700@google.com>
Date: Tue, 12 May 2026 13:43:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 043/270] usb: typec: tcpm: reset internal port states
 on soft reset AMS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, stable <stable@kernel.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20260512173938.452574370@linuxfoundation.org>
 <20260512173939.360401506@linuxfoundation.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20260512173939.360401506@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C1BB529906
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246671-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hi Greg,

On 5/12/26 10:37 AM, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Amit Sunil Dhamne <amitsd@google.com>
>
> commit 2909f0d4994fb4306bf116df5ccee797791fce2c upstream.
>
> Reset internal port states (such as vdm_sm_running and
> explicit_contract) on soft reset AMS as the port needs to negotiate a
> new contract. The consequence of leaving the states in as-is cond are as
> follows:
>    * port is in SRC power role and an explicit contract is negotiated
>      with the port partner (in sink role)
>    * port partner sends a Soft Reset AMS while VDM State Machine is
>      running
>    * port accepts the Soft Reset request and the port advertises src caps
>    * port partner sends a Request message but since the explicit_contract
>      and vdm_sm_running are true from previous negotiation, the port ends
>      up sending Soft Reset instead of Accept msg.
>
> Stub Log:
> [  203.653942] AMS DISCOVER_IDENTITY start
> [  203.653947] PD TX, header: 0x176f
> [  203.655901] PD TX complete, status: 0
> [  203.657470] PD RX, header: 0x124f [1]
> [  203.657477] Rx VDM cmd 0xff008081 type 2 cmd 1 len 1
> [  203.657482] AMS DISCOVER_IDENTITY finished
> [  203.657484] cc:=4
> [  204.155698] PD RX, header: 0x144f [1]
> [  204.155718] Rx VDM cmd 0xeeee8001 type 0 cmd 1 len 1
> [  204.155741] PD TX, header: 0x196f
> [  204.157622] PD TX complete, status: 0
> [  204.160060] PD RX, header: 0x4d [1]
> [  204.160066] state change SRC_READY -> SOFT_RESET [rev2 SOFT_RESET_AMS]
> [  204.160076] PD TX, header: 0x163
> [  204.162486] PD TX complete, status: 0
> [  204.162832] AMS SOFT_RESET_AMS finished
> [  204.162840] cc:=4
> [  204.162891] AMS POWER_NEGOTIATION start
> [  204.162896] state change SOFT_RESET -> AMS_START [rev2 POWER_NEGOTIATION]
> [  204.162908] state change AMS_START -> SRC_SEND_CAPABILITIES [rev2 POWER_NEGOTIATION]
> [  204.162913] PD TX, header: 0x1361
> [  204.165529] PD TX complete, status: 0
> [  204.165571] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES_TIMEOUT @ 60 ms [rev2 POWER_NEGOTIATION]
> [  204.166996] PD RX, header: 0x1242 [1]
> [  204.167009] state change SRC_SEND_CAPABILITIES -> SRC_SOFT_RESET_WAIT_SNK_TX [rev2 POWER_NEGOTIATION]
> [  204.167019] AMS POWER_NEGOTIATION finished
> [  204.167020] cc:=4
> [  204.167083] AMS SOFT_RESET_AMS start
> [  204.167086] state change SRC_SOFT_RESET_WAIT_SNK_TX -> SOFT_RESET_SEND [rev2 SOFT_RESET_AMS]
> [  204.167092] PD TX, header: 0x16d
> [  204.168824] PD TX complete, status: 0
> [  204.168854] pending state change SOFT_RESET_SEND -> HARD_RESET_SEND @ 60 ms [rev2 SOFT_RESET_AMS]
> [  204.171876] PD RX, header: 0x43 [1]
> [  204.171879] AMS SOFT_RESET_AMS finished
>
> This causes COMMON.PROC.PD.11.2 check failure for
> TEST.PD.VDM.SRC.2_Rev2Src test on the PD compliance tester.
>
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Fixes: 8d3a0578ad1a ("usb: typec: tcpm: Respond Wait if VDM state machine is running")
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable <stable@kernel.org>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Link: https://patch.msgid.link/20260414-fix-soft-reset-v1-1-01d7cb9764e2@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/usb/typec/tcpm/tcpm.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5728,6 +5728,8 @@ static void run_state_machine(struct tcp
>   
>   	case VCONN_SWAP_ACCEPT:
>   		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> +		port->vdm_sm_running = false;
> +		port->explicit_contract = false;

Please drop this patch from the queue. It was incorrectly applied to the 
VCONN_SWAP_ACCEPT case instead of the soft reset handling due to context 
fuzz. I will send a proper rebased backport for the 6.18 stable tree 
shortly.


Thanks,

Amit

>

