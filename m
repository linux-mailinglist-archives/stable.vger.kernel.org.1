Return-Path: <stable+bounces-212921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJVjGo04fWlMQwIAu9opvQ
	(envelope-from <stable+bounces-212921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:02:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD74BF4CB
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48106305982E
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61D364EBE;
	Fri, 30 Jan 2026 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NnqdysyG"
X-Original-To: stable@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AEC364EA6;
	Fri, 30 Jan 2026 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769814037; cv=none; b=SdJIVLOoez9cNjEGnk9VGLEYuHnNTOQXh8uLlOszQ/HqVkNsgrTRcgidASDG/bHdQAY6B8eey5bAFC60lt5hYLU+1CaOF98GRzScLuBvg5oohQAAaSj/ODk0iGXLi2ubt4DviNCRtt8d6Kt7ymFBpbVRoWb1IP2fGjSwrcitzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769814037; c=relaxed/simple;
	bh=7amOVhwEswMxix3YRsOAK+uY3G4S7SOWKYxYoumlp/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORrJjeGl8Dvc2j3OXlw9QyLX6eN8XMm65Hk8r9bKEgjiCCC08r1FKicIVMYgRdYPz/paP+YQUdfymMR5vJs/obUt6N2x2rhic3WJtbrLvmRqtxdSNhIKT6C65Oq2aJYNFOT0vBITbJ8kXI0fATgMwePyPkSQ69h/+k5fDB8lMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NnqdysyG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f2s1H3bkRzm4ql0;
	Fri, 30 Jan 2026 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769814032; x=1772406033; bh=O2JkvURvRK4OyrBNFDyITmb/
	tZoBffSL7tR9HU4jlo0=; b=NnqdysyGOkN01H/kjZfcR86vLUifb8N7ZADSN4Aq
	jau0LlqJ1WJsinwJAYO+6bKs3SGON3WSG9j7ReleIhgiJbDSO60AAsyikJ4ogrhU
	cpAcbwvovwFJAybgAV0whUsmYV9ly8fOwbhIvbixd4bBpdh4Z5572iSUi8JGcQ7t
	FDO2g2gUB+a3JWwK9UVWN2uctDjT9T6cpw5YgeaiMdtKqwyYPdoL9UBxsVhWhydU
	fNJQ2qgNc11QGJafLWOeDnEx9oGxEJnXsKZs6SP0GdKnqYFKC3FKhvN3tKi1oRtu
	WGPNtGbG8TTDhrzgR/pXKEs15i6zOqII6Z6KNu3EBDxZqQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z-rf8S79pmle; Fri, 30 Jan 2026 23:00:32 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f2s162KxzzlgyGd;
	Fri, 30 Jan 2026 23:00:25 +0000 (UTC)
Message-ID: <91ce1532-0af7-46ca-8d3e-fa2cf063b18c@acm.org>
Date: Fri, 30 Jan 2026 15:00:25 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] scsi: ufs: core: Flush exception handling work
 when RPM level is zero
To: Thomas Yen <thomasyen@google.com>, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com
Cc: Stable Tree <stable@vger.kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Peter Wang <peter.wang@mediatek.com>, Bean Huo <beanhuo@micron.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Subhash Jadavani <subhashj@codeaurora.org>,
 Dolev Raviv <draviv@codeaurora.org>,
 Sujit Reddy Thumma <sthumma@codeaurora.org>,
 "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER"
 <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260129165156.956601-1-thomasyen@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260129165156.956601-1-thomasyen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBD74BF4CB
X-Rspamd-Action: no action

On 1/29/26 8:51 AM, Thomas Yen wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 0369043ca010..8c88dd5c2cca 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -9997,6 +9997,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>   
>   	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
>   			req_link_state == UIC_LINK_ACTIVE_STATE) {
> +		ufshcd_disable_auto_bkops(hba);
> +		flush_work(&hba->eeh_work);
>   		goto vops_suspend;
>   	}
Reviewed-by: Bart Van Assche <bvanassche@acm.org>


