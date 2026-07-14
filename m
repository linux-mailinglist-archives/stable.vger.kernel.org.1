Return-Path: <stable+bounces-274471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LLknLwRsVmoV5QAAu9opvQ
	(envelope-from <stable+bounces-274471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F6E757310
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Bbr89G8C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274471-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274471-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77DA30E5856
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78A4E379B;
	Tue, 14 Jul 2026 17:03:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C14EA378
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:03:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048599; cv=none; b=jCFJVzKSaPfJhVHJ986yeXLYKFGHmtNRnRChrWvxzOLx9bLeSzNV9hiLpg8iY5No2zU4eLedSqrL7x7siWseJ9TEmaHlvK/WG5lYO1ngX4GfsboiTUl9TICDLqgQTTSkPsXRq+oRKKSsJYliaJVp6OfXH7Ya7cIQ+9XDPSLNvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048599; c=relaxed/simple;
	bh=RrM+CrO/r8o7FGUOsnl8gZr1EiYzoxDBKu+JkNQEhU4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NVGi/ykhTfLiymWpvDKy6qsmaQKrzRlKIU4S34Teba44RqmGHtFKBmowP0rXOfiityoS2+6Z+WFcqQDUwzMukCmOZzO6M3nBKT6grg3IHDx4+4pNscTVmtYhLqB78+mulG7w4OKYztYYGUbbZjvHiP49P//Dov+pjrEeQ+la9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bbr89G8C; arc=none smtp.client-ip=209.85.216.98
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1149371a91.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 10:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048597; x=1784653397;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3XaKw1mZ5safaShnh8fqMEdlQ2rL6BwLt+Z3QDeOIY=;
        b=NlI3qpwMaB/+d7cMnbD0HN3sPp9fbm5jTlMlwbmRxxtyXaCsfQjTMtrapCwbRWMryI
         lTPnycrA/d+BYQj5+mfT2MxEC0iCJu9PMX4DwawgPDy/H/eQo7HGEcaKGn6PAxdAfP1q
         0LitH1O93O6bTtMTG34d2eObWtsQ6ZVT8gaHKQJ9MjN6UAuLQ4GGopX9Jif+fEob9IK0
         JMCrlZfaGbFd1oTXiU2ZJVbKDXJYAWornQ2rM/Pgta/6otVNct+7N6aNjrbGyIx6CqJI
         pGfXmswhKU0K8vyXwfJ+oJ9eq0IU1W5uwFeAzjBL2PWFNJGlTS4lq0at3H2puEI2cqZL
         6qGw==
X-Forwarded-Encrypted: i=1; AHgh+RrpE1CuFRdk11vYDQxpHYWUw5uVt9JovM/fQ0appHgX8h2yY2up3DdDiHjnBvBzktYgkmo9cl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLptQBcUSeMPweeK7LcBgyn1AVCD93nF8bbQCPQ1yg8ATKOMaC
	gKcQlWHzstFF743axk9npvJZzNzzesZO38+FPvdhIk/vOHyGsXoxTTVyW7A1iSkDrMRYdK9yHbO
	BZw3lLP7PQNx0hsmqWlGnNb84QXab8IeTjf0BuuWZdCSpStL91eRdX43EORTqAOkiESy/kDJb7A
	30n2tWXsK1bwAGwOUu4jW6E+n9Gag2fdBNCVkQdl7Rc0cZLFcro3GQYkqITwOn6DXeoXxEyrjE9
	jxa3o8KvPUTA0TGcw==
X-Gm-Gg: AfdE7cnDPnqlNsmkF66KjGoQICgLmMQksm6S1an94G/h1CZAnB9QZpcVFhffvWX7Uzt
	hsvukZ5zVSlOsyd3saEdOFE4cVZfQq+cfJSPQN2/Y+C/P0p14on4lRV++ik5068/WmWA3U9H848
	GmbX83/UxTF5H2J7c9dccLNJG8k3pcdqBdUqaBm4czDGHXRvXBudXDrI1Hh0kgh0puIFVJUojph
	YljPhVa0aQtdijPmPB7kZjci3FyFUOrI0+AlfawBQ+93NoNi6wzrblU8n636kny6dcj2VTc/5QO
	WIYWHBWzbeoKHSKYsSTFM+iAWgsgTOZoFvnXQN/9EdKEKQpT48BjRlYKVIZeCQmqLf7iYDONCQR
	dk7PdzPUW4hq8E7/si8hX96jHLoGmWJ6WGjcCxBVChdCkVEkJdNVGMbEhE6USB/ZfhcCJUptOQb
	UrUcqVW/1DjOVZaEifqBmNZdaTm3pJFWdjxfVp+st9E0jt0Wk=
X-Received: by 2002:a17:90b:4c4e:b0:38d:84ec:b03e with SMTP id 98e67ed59e1d1-38dc73bdd34mr11771890a91.6.1784048597063;
        Tue, 14 Jul 2026 10:03:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38e1749ede2sm290025a91.7.2026.07.14.10.03.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:03:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15f0aea084so248914366b.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784048595; x=1784653395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3XaKw1mZ5safaShnh8fqMEdlQ2rL6BwLt+Z3QDeOIY=;
        b=Bbr89G8C/hCPo4rxLT04YCJKbw6L1G7cX+j81dRW0ObwBFoGbY2AdZNZoUG0yevACJ
         yX3tnqdX5N0VnTnmWhITnNHEDWBuBEv1Pt4DAmU3T+H70IktJSgJ9d11DnIBYJ6qB0NO
         eKOirIJYOP94wc7JJLGo88sQ1I0txI/yD4uCc=
X-Forwarded-Encrypted: i=1; AHgh+RpzGz9veJieFTW6yqZKGzyApjQRYX9hxCVnsM4j0XUycFx2FlSnvigtC1uOsuZviPHKchev8HQ=@vger.kernel.org
X-Received: by 2002:a17:907:8e11:b0:c16:5b2e:f972 with SMTP id a640c23a62f3a-c165b2eff60mr300352966b.53.1784048594393;
        Tue, 14 Jul 2026 10:03:14 -0700 (PDT)
X-Received: by 2002:a17:907:8e11:b0:c16:5b2e:f972 with SMTP id a640c23a62f3a-c165b2eff60mr300349566b.53.1784048593952;
        Tue, 14 Jul 2026 10:03:13 -0700 (PDT)
Received: from [100.98.74.8] ([109.37.130.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15b7561db1sm1136622566b.12.2026.07.14.10.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:03:13 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: LiangCheng Wang <zaq14760@gmail.com>, Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
CC: Kalle Valo <kvalo@kernel.org>, Angus Ainslie <angus@akkea.ca>, Wig Cheng <onlywig@gmail.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>
Date: Tue, 14 Jul 2026 19:03:13 +0200
Message-ID: <19f61952868.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260714022859.1849447-1-zaq14760@gmail.com>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
 <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
 <20260714022859.1849447-1-zaq14760@gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FREEMAIL_CC(0.00)[kernel.org,akkea.ca,gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com,infineon.com];
	TAGGED_FROM(0.00)[bounces-274471-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zaq14760@gmail.com,m:gokulkumar.sivakumar@infineon.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:wlan-kernel-dev-list@infineon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,infineon.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52F6E757310

Op 14 juli 2026 04:29:16 schreef LiangCheng Wang <zaq14760@gmail.com>:

> Hi Arend,
>
> On 13/07/2026 12:51, Arend van Spriel wrote:
>> Looks good to me but the stable instruction looks confusion. What do you
>> mean. If there is no 43752 support there is no need for this patch, right?
>
> Thank you for the review, and thanks Gokul for the detailed
> explanation - that is exactly what I meant, and sorry the annotation
> was not clearer. To summarize: 43752 support has been present since
> v5.15 (commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and
> initialization")), under the SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 id
> name. Commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
> incorrectly labelled as Cypress (CYW)"), which landed in v6.18,
> renamed it to SDIO_DEVICE_ID_BROADCOM_43752.
>
> I also have to correct myself here: the boundary in the annotation
> should have been "<= 6.17" rather than "<= 6.16", since the rename
> only landed in v6.18. Apologies for the extra confusion.
>
> Gokul's suggestion of cherry-picking the rename patch together with
> this one into the stable trees sounds cleaner to me than editing the
> id name while backporting, so I would be glad to go with that.
>
> If it helps, I would be happy to send a v2 with the stable annotation
> in the prerequisite format from
> Documentation/process/stable-kernel-rules.rst:
>
>  Cc: <stable@vger.kernel.org> # 74e2ef72bd4b: wifi: brcmfmac: fix 43752 SDIO 
>  FWVID incorrectly labelled as Cypress (CYW)
>
> Please let me know if you would prefer that, or if the patch is fine
> to take as is.

Cc: instructions to stable should stick to the stable-kernel-rules format 
if possible. I suspect there is a bit of scripting sifting through it.

Regards,
Arend

> Best regards,
> LiangCheng




