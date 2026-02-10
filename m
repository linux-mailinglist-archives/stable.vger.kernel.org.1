Return-Path: <stable+bounces-215662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG97MZs2i2neRgAAu9opvQ
	(envelope-from <stable+bounces-215662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:46:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D011B606
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A394C304A153
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442732A3C3;
	Tue, 10 Feb 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw8WzPB0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD49329E58
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731075; cv=pass; b=bLRW9psgtLRVEVmbeDKxZ513hzZlXwK97NRd82o5XbnJXH/n7KaBtEv9GAe5XdMihdaNsy8VEynqtsag6xcI827pfj7T9ttEPlU+E/i+bfwoJYUK6VoTT+WHS6lLnfUTA5kbIxDVxOt5kGtfNuiQ2FUTxqcw/unrWzcfzC73tSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731075; c=relaxed/simple;
	bh=My7H0zv9om6eGFOqwrY8WEQgO1PL3LXVOyrjI3ZQRjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJieMoKRvvpcmII4GUeFAyqQRL2+1JjV2gzJpS+68+ycBfdjefapkicplTM8aGj2ECAnAAVJiEOOFLlv4HWAf/CiDJ+94Iz5DpYfNhrKn8y0dAuQc2Xkvu64w+3CAbQWZm5iWzso0RrLy/US6b5SMwNb1XK7f1PucT3xPnfyboU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vw8WzPB0; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649dbff9727so3538995d50.3
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 05:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770731072; cv=none;
        d=google.com; s=arc-20240605;
        b=MU92sWAPwta8vTHw9xGBLqI5NlWv/M3hDCg6oQc88iySrR87vOgplL0NNtYEJpjlAL
         BExpNTKFG/y3OvsaTJcoP1VzRCZDGjUM/E3sDCHYgNTzjfbwoqBqqX18NAtEtVp8FdLu
         zuIpIxMUE/OJzIO+5lxqbkYKajl2/jH58HU353Ud4twK3cpFh+53ylojVcwGRVdpVmmF
         vFmv2jIZCHMdWS0RVUWhugihALVUs7X+6mVOtCe67G6GvKDSq8KI7Y43tXAqfLWxrzBw
         NumjZ/pwvxt/nZG3cMR5+vAo+pQxG/GnNZGz+pT4i8/MFGuRy9pDFGryDK4cYzRsh5bw
         F3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cO0B8QPhPo0Y3GlbKCDusifXNzaiAeSd4InIZCnguwY=;
        fh=Xsba7QkJK+SzC7k2VxS3ygdEDORhfW8P015R/VYSe24=;
        b=gdqmH5v4ypgJj71NLCyjvYtcHyB5s9sq4faiuUZIIT4xi+yFi46tUaTpGfKZv8ysCJ
         l2vc+xGAvj/+LuyS4+We0E32R3eoGOnZFaMHjgh0nWMGFePpvuZu/fEC0E3D2P5ak+tt
         GOM3WcYPJ6ic1rCy5uz6sQS81RbE73ITj+uJ+mILL1iAWmkoiKujS1ioXQqEK3LT91r/
         fuo5vvO92j3+55nLvc/TEeIG6igJaXxm4zL6Z0TcJQ1G/oMGpuhkrIWueK+V1CkTU2ec
         22hmqCMr52oIqtItqxQqyFAZclAbF5Oj/JQ946v4h9oC14tVSoN0aMTc0e7LTGEt3rhi
         XTVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770731072; x=1771335872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cO0B8QPhPo0Y3GlbKCDusifXNzaiAeSd4InIZCnguwY=;
        b=Vw8WzPB0oLcYWhtQSx/BjgeR0IIJffAqCy/AtF/PqSjkoeWAJ3MPMv1QGab0EKCEJp
         hYOrRYbpzrt0KLCPL8dv2ImW+w3GICWzj0n+MLSB8F4DaPx0w3X9pqcj/75b/SrDmK+0
         dS6JJILoKeKUQwgO44dPaUMEmOtfdsgxTXuM9w/SFYfhDEhVXbdIppsVZ474fE4EH5z8
         W5tQMD6yyOGACdGI2sBNuBPlvNFy1h5C8ojSZJ9FMMJx7l2OTuwjy/VDX4yB7L05G2NR
         AU1NqixA2Lis3AnkTkzixffUUqPnjIMvk9NfWEWDvDQciQRcfQzdH3t2uFPeYph0ihxZ
         tAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770731072; x=1771335872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO0B8QPhPo0Y3GlbKCDusifXNzaiAeSd4InIZCnguwY=;
        b=M+MU4O3Vfox+FgBpctv0FkNEiBeHtivCbXyt+wi0S0psKNPrPDFew1EcpIBIQxZKWM
         +olNCXP7hKwbaM8p8hJZyHINo6D5oWXEguNC1OtDbXfN6vPLkmIEvK/y0S2t9yXPgaq3
         LpWLhBadUBf1yLRoPbWxuA1u1ClXG46qNk5uz21Diw6izv0JtsyiiVYH3Xgxb+MnU78t
         SQ2ZSFMYq3Fay4fHVcCwRr8e3puwy5nQSwR6JANzsjsJAJVouiknpvJkWOKGFGy1dliS
         yPBP/x2syaOOhZF4pnsP5S29JBhH7Qq/1497iEMOQsJJXhBOIP9QS2piZhy7LRTH+2Mt
         Yk4g==
X-Forwarded-Encrypted: i=1; AJvYcCUn714ZHME3np221eepkIsO4Gpgaw96SXp2u+O8vWYPd+fBihioa7I2k/2g6NNTwTqBV0BLxbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/Dj+EUHmxSCe7X3AAvHwSVzqBe0AUlXZeo6k+QkaJU+VOyPj
	jFD6AvVvJAJ3Piq93Wjx0xXgsNDwC7C5MdKBeESLlJajptMWEjZfhs7+ijzHAk8hpvgYCFUzx/U
	Ow03rG+3qhpPrHUJ5FlClVV3qa076VDEmQhnZg4iUJQ==
X-Gm-Gg: AZuq6aLblexeuVemRaA9B8NbHMUq4j/Kj2HqzA/ptDi96HywoCTHlWzoBJfwC0XsE8J
	FHmalpG8E4qcsQgOtKulqrLHpob1/WxPzc5fFSL37ioUkv+6tcSiuHUizbmehaWAdwRlTHnroAf
	7oJTBtgSmexLncKUxq5sFMMzt2/cUFyw3yXuf6x1/l0OGypA3YdDEvCKMJrW66ErHVtDBkTqWjy
	SxtO+QjVqv+0Nne0TVtj64t4MeaTtmSd4tG4HgKPCo5uCMSoCLY57cydfb4fmJslm3inwkbsP5a
	RDy8SXnb
X-Received: by 2002:a05:690e:b4e:b0:64a:f188:976f with SMTP id
 956f58d0204a3-64af1889b6fmr1730648d50.45.1770731072184; Tue, 10 Feb 2026
 05:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Feb 2026 14:43:53 +0100
X-Gm-Features: AZwV_QhTZ9KRaRA5GTHx4N22K6Lp6hSICHstQ6937DBI5S-nFi13iuFlfu6mtC8
Message-ID: <CAPDyKFocm3yRTG0TJJRxfDvJMjvvvri5fzi_HoNY4YSd-41oKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] soc: qcom: ice: Remove platform_driver support and
 expose as a pure library
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	stable@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215662-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: 0A1D011B606
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 at 07:56, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series removes the platform_driver support from Qcom ICE driver and
> exposes it as a pure library to the clients to avoid race conditions with ICE
> SCM call availability.
>
> Merge Strategy
> ==============
>
> ICE patches (1,2) through Qcom tree and MMC/UFS patches (3,4) through respective
> subsystem trees as there is no dependency.

Just wanted to double check that this is really correct....

The propagated error codes (or NULL) are changed in patch1/patch2, so
is it really okay to pick the mmc/ufs patches (patch3 and patch4)
independently?

Kind regards
Uffe

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
>
> * Added MODULE_* macros back
> * Removed spurious platform_device_put()
> * Added patches to remove NULL return
>
> ---
> Manivannan Sadhasivam (4):
>       soc: qcom: ice: Remove platform_driver support and expose as a pure library
>       soc: qcom: ice: Return proper error codes from devm_of_qcom_ice_get() instead of NULL
>       mmc: sdhci-msm: Remove NULL check from devm_of_qcom_ice_get()
>       scsi: ufs: ufs-qcom: Remove NULL check from devm_of_qcom_ice_get()
>
>  drivers/mmc/host/sdhci-msm.c |  10 ++--
>  drivers/soc/qcom/ice.c       | 127 ++++++++++++++++---------------------------
>  drivers/ufs/host/ufs-qcom.c  |  10 ++--
>  3 files changed, 58 insertions(+), 89 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260210-qcom-ice-fix-d2a3a045b32d
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>

