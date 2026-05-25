Return-Path: <stable+bounces-254129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI8YGcgvFGqUKgcAu9opvQ
	(envelope-from <stable+bounces-254129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:17:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42495C9D9C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1BA53006794
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CB32B119;
	Mon, 25 May 2026 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gtFRCKCA"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D53101CE;
	Mon, 25 May 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707845; cv=none; b=kHiDiXuQrigyexEFRWvBKO694tsgmCHh6RlStS99F9JcVaZy52ZgcwrT93YiVR0jbvSmimzdMwQPHzfwa7uU0ov70lwcwrygWrdZFyLkQ4gbwlmLfmlS7+1EEsC6qvdmokJlV0MHJ7rNBpan7CWgOsuwnVtu9TAvr/sgvmOrm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707845; c=relaxed/simple;
	bh=Ltq3DgrhDN6ZWtPt0JiF9Y1wmYwtnNCB38LahL8PIgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdHB97RpQTu+CNfQDBpnGAHL1cqexpIsU9dFT8eWeo7T8YCcJOdfL8rxkVct0EnWBQ2jKMzSlBH9ANWteR6j+x4LSjb++BIIaRU4f2WabKAUMMVGFqQlGPH0fJZOs/bSfPWPeEq0WT+phKI7oFxXe/lQgcxj++Y7uIBL5bxWQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gtFRCKCA; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779707829;
	bh=Ltq3DgrhDN6ZWtPt0JiF9Y1wmYwtnNCB38LahL8PIgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gtFRCKCAW8pk171s4JGcNhWwtPh6eNk3Cp1vlHUReMIsIlu7n7bmwmIqyKSFn3GOA
	 OtKxJkSH3+aFnySDZkpB85eEwNA82dtAA1X9NDOl4LLI8Wl0EzuLlpIVNTsjTOf0W1
	 h5kB3leJOPy4RVbXjPEXVxdU1HDv+unIwVAYYQ8k=
Received: from [192.168.1.40] ([183.241.55.175])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4460922E; Mon, 25 May 2026 19:17:06 +0800
X-QQ-mid: xmsmtpt1779707826tvbjogym6
Message-ID: <tencent_2F1F1B920DD60238AD30F50D40B44F35EF08@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r75f79KJE/0Yvqq1I34mHh5QOS/YK5hDnKp3tlobVHfa5B4W/TEv
	 7TTiJgtVnpiGM3G2V+Dl/WxkbRWv7gdIbs+thZ/FjPha6D91Sch27kYZHetMygH5YcfK2iNwENnp
	 Ak6Sp1glIarfL3T5533uMLvv6zzdFofQVf2vrIiP2vG5srsQHxbnt+JICqS6OipKK5IpCtNHgx4o
	 +arAsf9z4sRfp4GameyscIEcecKSrCT/GZPZhQrxdf7/R1/+hTbT3Umw3QxI70aoLtflj5tOHYYr
	 PTj+RQI/n1yRvkSznFfJoOuFWHFAaI3MFGFo2310ViaEVUTYx2z99OBRsUirVGUNU7K6Z6R0NsgL
	 h7BuQMsD3/pTmhSzUWwQysly/uLPSgKMYu7MNgSn7L4Y6Kn8WIyztK/h87D44htw4Ax+mAu81InT
	 vS6JEouzlJJDwoCi3sFpESDUyASKyrMoPfKF8bX0w0k++I9Ad+w1osWatzFITcOb8THXF6sCyF4I
	 TmiX33ldWrgeOtBxaBL/FDqe2zA+PZLup9ZUkR73gACIl9RKbmZ4JDqeVjmQdIMEdP6Q3/0UBPzY
	 XOiCNGaEsNrdY88chCykTZAzHJOkOV6tGEsq7Sh9m37KVO+CP+YblIoPJHF7a8nExupCLSXPlT+b
	 inrTwEjlF4kbSw8UF0AMvmReGI08PQib/vIBZXW2ui6Zk8ZiUliUHw8WOjoezLhaqqMao4qF5te1
	 1SrIslQNdhx82q8ODdPny544ftRhQUeRIHBZaG7//aJhKwIVWT1kMD2RsVC7vlHFdS0H5UH4IxIk
	 dZtymX+vQkcePAncpr7sgqbYLI59lCJijQwma7XsIirKe7PHEEs+ZHjf5mZXJlrUS/goshv+K4ay
	 1xDok5ojPmMl4GNRxsf7tT9dRqxhZCvNH8RbJ/si0faMY9bUdBPk70Tm7c8I5dy//G9R6F4xEV+S
	 hmdESLutHez+icnaMFIeDyrg4yK/6l5lpxdaeQGIb6dbzLzTgQ9S6kARW315DZsuCB0okLeXsWTX
	 BmIRubKEAoK2UZtfhNViTOSHpOq1QzqVfx/PLiU04aCjeSAwTPzw/N6RO60d8cc2awJxT+Bg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-OQ-MSGID: <8e2129d1-3c99-4fad-9428-1a1373c26b9b@foxmail.com>
Date: Mon, 25 May 2026 19:17:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/1] ksmbd: validate owner of durable handle on
 reconnect
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, stfrench@microsoft.com, d.ornaghi97@gmail.com,
 knavaneeth786@gmail.com
References: <tencent_DE479764A6B5230E038C7F4315AD4C0DC606@qq.com>
 <CAKYAXd_dXtirA0eFx68ir_-FzdgPGNcmRQOSvaZdZABkPhH1iw@mail.gmail.com>
From: Alva Lan <alvalan9@foxmail.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd_dXtirA0eFx68ir_-FzdgPGNcmRQOSvaZdZABkPhH1iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254129-lists,stable=lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,microsoft.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[foxmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid]
X-Rspamd-Queue-Id: A42495C9D9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/24/2026 11:13 PM, Namjae Jeon wrote:
> Hi Alva,
>
>> An additional adaptation was needed for 6.6.y: in ksmbd_free_global_file_table(),
>> the call to ksmbd_destroy_file_table(&global_ft) was replaced with
>> idr_destroy/kfree, since the function changed to take a
>> struct ksmbd_session *. This matches the approach in upstream commit
>> d484d621d40f ("ksmbd: add durable scavenger timer").
> I think we should backport the upstream commit d484d621d40f ("ksmbd:
> add durable scavenger timer") first, along with any subsequent bug-fix
> patches related to it.
> Thanks!

Thanks for your review. I have sent a v2 backport.

Alva Lan



