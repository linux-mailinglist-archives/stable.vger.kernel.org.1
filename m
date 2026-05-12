Return-Path: <stable+bounces-246670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPcNNkOSA2ru7QEAu9opvQ
	(envelope-from <stable+bounces-246670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:49:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9905298D1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0643112B40
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206583B7B76;
	Tue, 12 May 2026 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrU115/t"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728C2EB5A6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618499; cv=none; b=XvDsPCep+WQsm4/xgK6+Hd2s79WHyMr1A/jvUoIBfq9etyyoV2zdWW3L5jpttyKUCLYPQbGaT/nYw+1WgHwrgaKYBJluIE0WFDElS9FoLGIcJ5kc74Krh64D6XMmRjqhxXxGJtDrhbFP75xZzd7zDDm1uayaMHp4rjQLmbJEvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618499; c=relaxed/simple;
	bh=mZubmlekLduv78PkJ9UspZtMtIutTKl+OgZbzRPCyxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlyMXTOLvic3AItf8F1kVLEpDb6PQT8ALyz9ngtIKn7W6MvrKQVdFi8lvOvOiJly9DDOAdXjXZfwwFNGnHOeq73nyhRKOz8z1NACxZTAtMqpzD+oc65jvyUkH6R1EZrGj+Qla7K0eu2zKlDze+rXBqUBJwZS8AczZYCmQ5jJRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrU115/t; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f3c623322bso9992447eec.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778618497; x=1779223297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmByf/1D2iszo6zYS41ggp3d6e7T3VLwXedEo3RdCos=;
        b=rrU115/tDJz68I9NTp8qfFjFaTWj0bsoI5NG19HjlLCsrLbmzTHSxNQzwsS7ZxGyDS
         m0lUtINQWFFvQM9qDydE/YXI0AT2yLKi/Qis08BpSRYtTaSxWN14UjjBQ9ZfLieQOzOd
         2SZLFP4ObDOTM1/AFwYxTCI7rK0Xu3p2mTQwy5kjw1Q5YHxBtPd/joXRtvChqM/UBLiS
         THUBJeAuGLTB5W1mETmWHmcLJM03KpSmBtttcdFnTKCOukbDYJwUzT/kkJ+u5no+6E8p
         6cYFz2rNEnlzigQccFH8Chf8rlbg8z/pdW2lI2g/4CTnlhJjeQVb9vCyTIPE0gL1SzKa
         hOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618497; x=1779223297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmByf/1D2iszo6zYS41ggp3d6e7T3VLwXedEo3RdCos=;
        b=OqBtIbfzD5ckVFVjIgHB/80HuFUPB1DYdCEAIiM0uDv67ovxxXfPJWk3X/h44PO0ba
         2kCesKLCL8i+H795QQ/iitH25j0pOPvL8TW0vcAzjYnbA7tg15d4sS+ncJKWN1O/XT1D
         lDvfDJ0oP6paagcdafAhH2QMOrShujZxtdKmn/NamNYcDXb59LmfcM90/8MpDM8FyH1I
         fTb8+YZrY2UMaXaCtvZ4rA4zivoTa2BPtwwOzXKUmjye80d0Te0Hk6rt5hoKaVx5r0jw
         EFJKj9Q9QjubpI84T6nyJ6p4aQ7Jl0/iIbEUxrGAw+A6+pV8RsUI0uaJX8NumLh/ovJ8
         fo+A==
X-Forwarded-Encrypted: i=1; AFNElJ9NSy3KIz0FZbu8hnnLZbBqBQRh6d79wM+HsGbCH6OZXmpfzhBoujAzq1liPIDxHb3uLOmS7d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9juz3wM9aShoDUbTvu8nbZj/PNM/0y4rMkwNt+e0k43tHRG4
	6XV0zoJ3WzqE58ZNGz6CMtK3RuwwxF7HqRupNR3XCruJnl7WK2yzBxWpH+xZk2+D4g==
X-Gm-Gg: Acq92OHSDAved/Rf6zQx5wCxX1kOdYWsvbec0ahkXu8XeeDh6bUPvAO33HjOsqf6pT0
	VsIhfG4Wp1zdIVYMO5jSB9+UPE0KChVx3s+3SUHbHmB1w8IFT1uL2wLo6CXVjdgIpXXgMVK1ifv
	zVnXJo6V3hEELIisV6m9+5pW6cYURpx1E+iVi3XwUZJ7xzj2ClNNfFTLHZswzC2X+XHPC0lhkrE
	oPby8TMLqizk62x9lSLGm9gALi310VAumlUpxkBZE9WCeS6cdEMzFRpY51p4bm8mlVcV4UhDbXv
	ifwVGfEnuhN1C9lSug97Phrf2gATntAjrzEnjauBNspqG9WIfSss7ulIQumec3mXAkHIv4gIck/
	TXH+X+KN/pnWb9bTLNDrL2gC+alS5inLts3h/1fcGjiyLi0MsEHzmxPVhLUIL1eUt9EXsKG/p6e
	0VHc9BhNTQd/Ou/quwm1TQtq9T+C564NNumw4chdzFnZ9tG/DzaE2+AArMWJKstcgR+wrC79jab
	BwPAB7d7+tPx1gYHT5oKJqi98ZbycvUoITJ
X-Received: by 2002:a05:7301:4902:b0:2e7:120:137b with SMTP id 5a478bee46e88-30114251733mr550634eec.0.1778618495944;
        Tue, 12 May 2026 13:41:35 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:839b:f905:79b7:838f? ([2a00:79e0:2e7c:8:839b:f905:79b7:838f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb034sm19502303eec.5.2026.05.12.13.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:41:35 -0700 (PDT)
Message-ID: <3f6a00ca-6020-455c-a7fc-f16b02112185@google.com>
Date: Tue, 12 May 2026 13:41:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 046/206] usb: typec: tcpm: reset internal port states
 on soft reset AMS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, stable <stable@kernel.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20260512173932.810559588@linuxfoundation.org>
 <20260512173933.811124271@linuxfoundation.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20260512173933.811124271@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3A9905298D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246670-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hi Greg,

On 5/12/26 10:38 AM, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
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
> @@ -5614,6 +5614,8 @@ static void run_state_machine(struct tcp
>   
>   	case VCONN_SWAP_ACCEPT:
>   		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> +		port->vdm_sm_running = false;
> +		port->explicit_contract = false;


Please drop this patch from the queue. It was incorrectly applied to the 
VCONN_SWAP_ACCEPT case instead of the soft reset handling due to context 
fuzz. I will send a proper rebased backport for the 6.12 stable tree 
shortly.


Thanks,

Amit

>

