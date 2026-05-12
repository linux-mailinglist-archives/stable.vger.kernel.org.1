Return-Path: <stable+bounces-246672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NljChqRA2ru7QEAu9opvQ
	(envelope-from <stable+bounces-246672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:44:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13E5297FD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA1DD300B1AB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4EE36F913;
	Tue, 12 May 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM+q1EDQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370E3ACEE9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618647; cv=none; b=AXf5zZj2+tXE3j8/cTGRWHf7A7dguM6boEEzAF/H6I78JPDHZ19bCSLgy2LK6IQMO/RauMXMMqM4ra3d3oKeeJxuRbcgClMrZCdNdT7zeXX+NOjtZtZt0NV192VEY5gXaU5O9QQ/sbpnfAPd7A8umaq7/G/WV8ATbLptgT2XB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618647; c=relaxed/simple;
	bh=QZbJexH7roQz9CTKUMXawNyoKnHRwN0ff8bY6zYjaJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IymHDx4eCMyFZlVSTTFgPfA1lD82JOIK09teHqqz88FKKexOtP2OApdSiWsZt4l/1Nu6qMx+ysG8Lg9iHcRb8XJmgba9GFFRgxvpFVWEQK8DMqgM6wZKij4iF/0WOMaKwHVbAwUUfuYYP1zCeXk88L+akP1XMM4e0KU/e2KH9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sM+q1EDQ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13317450f83so988049c88.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778618645; x=1779223445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOTVoVYKuXInZTCg9uFW7YHTqL8MrCZvgH2OHC0a8Po=;
        b=sM+q1EDQA/J/Z7KALegr9hDSMJ8t614oFLLPmCC2j7BsAczHzcbfgqZaQMHQ8CoqVs
         x7MYRqlt3eQXka9OEF47tM6C9rNUahEwzW1DA8mMTPVgszVw2qP6v2B16yXBCzRY5pTq
         DAOFVGO1yNjL4QtGxmg3hxVCaKkvcnKxjZqi9rwLn6IkRAaF2Z4XoULGa64dz9Jqo9Hi
         FlwUwaG8TZAfgemhw5o8ZZleG60AUUaGjiwCq2Q/MbbzCJF9nIXvO0SMtAQuyOdyJWGg
         c2A8QNLtMz4Vn8FL/Jg3rSyyjCQBxN2JAGCGszQM0jhu8o3xzmL5rl5tBhhQQyEyuzNn
         bVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618645; x=1779223445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOTVoVYKuXInZTCg9uFW7YHTqL8MrCZvgH2OHC0a8Po=;
        b=UH/sHzE/OhzFBueI8k7goQDVLB2C6OYc8f9ytX8uPZzS4cb8yUJ97nWng702nNRMBw
         LbKJb91ZnAIeM4P2zAxSUig2OgImDW2d5ez1Y1nIFHIaYMA5tr/+8qEdcIAQqMiwLRJM
         geUZ5ySh3ADnbWABIrrgNFUn2ef60Wu+VnecKxcnxQpUvV08W+VmkrX2reOHwbSnYmX/
         kHlewNCW7TfO07uxWJL5IrYZGwyYF2rOzFiHaz+TzEXor5h047Spt7n41XBU2D/zXsrt
         RhDKoMEpVLMfSHmz5m2qJpHQZda+S/IrBZXkgY/T08wkvrTiZNc6t+iV7CbEXnYReSNZ
         DX5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+NmaLvkjkQLJkB4kBnjPM9ayx6rwn9K3IOy4EwW+U0XhRpMMPMVFhWdnw4mvRQZzisdZJ/ZQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylvrt+Dm+44zjw5OkHgGtRVGIW8pF/LFwsqaJcoy8MF1BFWor/
	vanzwcP0dYJN2jVqKlBOdIM7r/uAs0iY8whr4NHw9VOQcoTRU8JXa1khelHPOGyQxw==
X-Gm-Gg: Acq92OEa6CnmHREfxxT1wsd7WYCQxF7DphjBFP+81KGHsMXtw4hutPDeU4ndqFbPg2w
	qo+NqR01v0cKDX/Pedpbe1OhxchMhvBdy6StaoTAKnC3CB2QvnhO4Ob7qjeVMqrAAlSgxr1SeJo
	f923cEbRpLP0S9k5hJirupp3/1FIn8iGf8coPkg86rY8s+csEoZxfCiGYmHbOBZ+FfnVj43mxlT
	5iWWOgTGm7s0sT6HAqtvmjHKE569Dh26atqhl5bttbvNKSqDOlzkVdsDLBUZSdoJzpJYN3QH+5V
	X9W+FWLs6bJsO6wJ8QnoTbslJjtWIvF60pyR6RsACqCwZGIv5UQzHlCuN7+QUz1H0BwhfTL8nlG
	vnUa3TGwvM2p8oR3ll4T6n3s1Cmu/pBUeqpsiEH9pQ8D3U1f4A0Biyzup23nT5mFaCwI+9v/p+C
	r7GRU7R4AMaHuQi46yvT22BLXWAs0OVhYNZKVmUjPdf3Wos3cDIA8nMLcB7OztkiosjnCuCUG1b
	qGNowUQvx5lstViEsMTZUgotraS6mj4keOi
X-Received: by 2002:a05:7022:6997:b0:12d:de3e:86a7 with SMTP id a92af1059eb24-13436bb1815mr297018c88.37.1778618644810;
        Tue, 12 May 2026 13:44:04 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:839b:f905:79b7:838f? ([2a00:79e0:2e7c:8:839b:f905:79b7:838f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm27852209c88.2.2026.05.12.13.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:44:04 -0700 (PDT)
Message-ID: <7eb599f5-b5dc-43d5-be49-bf4997bee3dd@google.com>
Date: Tue, 12 May 2026 13:44:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 040/307] usb: typec: tcpm: reset internal port states
 on soft reset AMS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, stable <stable@kernel.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20260512173940.117428952@linuxfoundation.org>
 <20260512173940.970675491@linuxfoundation.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20260512173940.970675491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BE13E5297FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246672-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email]
X-Rspamd-Action: no action

Hi Greg,

On 5/12/26 10:37 AM, Greg Kroah-Hartman wrote:
> 7.0-stable review patch.  If anyone has any objections, please let me know.
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
> @@ -5741,6 +5741,8 @@ static void run_state_machine(struct tcp
>   
>   	case VCONN_SWAP_ACCEPT:
>   		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> +		port->vdm_sm_running = false;
> +		port->explicit_contract = false;

Please drop this patch from the queue. It was incorrectly applied to the 
VCONN_SWAP_ACCEPT case instead of the soft reset handling due to context 
fuzz. I will send a proper rebased backport for the 7.0 stable tree shortly.


Thanks,

Amit

>

