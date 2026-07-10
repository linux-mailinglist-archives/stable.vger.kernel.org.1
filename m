Return-Path: <stable+bounces-273336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xWqgJLtiUWqlDgMAu9opvQ
	(envelope-from <stable+bounces-273336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:23:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E373ECA2
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Yh8+C3it;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273336-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273336-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FFE1307DEDD
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478033B6BE4;
	Fri, 10 Jul 2026 21:20:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80933B775A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:20:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718451; cv=pass; b=YIgyvcc0jxOSaA0SnwZiP4EJ6wy+GUGcW/nDiOdqq2p2K7r1SN1Z73bca1ME3l9vhqzm50qmXc1KiUhnQNE/SaXLZDWXQgvyQSFUx10n6FAH4jJd/ZuspzFEEWxL/sa/eaSI1q/d1rlVmyzs3KcQJuluXphJOKCL/zKiWHPJ3L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718451; c=relaxed/simple;
	bh=wkO38/dlD5gJBLaxlIlRDPnanLV+lBE5oM93sK9WuLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF9c2INPmgFnn2XjKMDrywTues8JFER+qgSy7c+LMrubBMHnXP0bH7yDcFlDQg1XT0BuBjusafPppBsk9wO1sIOWOmXT/0D9FpA2iBxtrl2N+PoKUpYSfJUjMCAXQv/MtRDhevlcPUY2+gScZKEb5tACfxy0C7kcSYt1LH7TAGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh8+C3it; arc=pass smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efec2c28f8so10890986d6.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 14:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718449; cv=none;
        d=google.com; s=arc-20260327;
        b=Wm8nLVxRtSv38ajbx5E0tqJ5ExaiC+B/Ru/3riy2EqN5lV9svYPW7c1Fm8B34Pdjuk
         cOS/lNp198RWC+DgBypuwUtMr8mzebG5VJ87hQKZF3EYC/Yvse+gPvgyKsgNXmyHqTRL
         mL0EAebfAoTxzFZJcIKfVsEUqYOJWdmrr0BuSqQ2Lg89YfW87/PmO5c7cBqInYrMtPfr
         0Pvf9TkJOOerwk2rqU10BbO5quB90OlrsvMmWMp9mULBVIJibHCDbr7jI8Y7KUvIJVjs
         SKG8NYfvmjX5wGsqZuBvVYQQN0lhFFN8J0W3blTM1+TAV1kJrfMOFrsLtOcnkGj5qMBb
         XZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkO38/dlD5gJBLaxlIlRDPnanLV+lBE5oM93sK9WuLY=;
        fh=pr6oQqTKWcr/2wHoSgQXuKGA12m0tHLiA9X9+xpU9nU=;
        b=jT8DfLhw0hjpkwOAehcNnjiBA0zCzlyzgxyVkqyoX01ZGfoqE6cJ5SoegsufrxSwN7
         ieINQSAclJdDANwmMXfOFlK/AZ27QzL+OefL54y2TVtPR/+jkOTYWAmGw9/t9mYsbnH6
         On7NOw6idaJnCXGPg7zR7ljZZF19GOSihGh0kTAE3Q5q5jFbd+W6UmHbc2RmvFuswDq1
         vGgrcFEqhEQh56Jb7S+RMcWE7hzXTuCv1pw3b5p2Z+7taageWVFkNvU0Eb+in5gYkJE4
         OkU0LpD5bR5q7d6W5a1Pkf2GnKcqVabvqIs4w2B+xiSZqJSYsS+cW+2dcBilbATETX0F
         vLqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718449; x=1784323249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkO38/dlD5gJBLaxlIlRDPnanLV+lBE5oM93sK9WuLY=;
        b=Yh8+C3itoZ3hdokDtlVugxbrV/BWCiGX/bqcjO7wWh9BIif5gp75jSMwWXFb+j1ZJ0
         nU5DOfu9AvdlTncsgDf8zvjzTM4ifbWKMTuTRj3eKd3yZOMhnTqHS/FsztQGITgE2ffo
         PeGO6N66YbwJb0iRCHhlJryxvFKevVdTOJXkxXhrXVxZE+jmojzBBD2+K7qnMz3RwXE+
         FnUdY39LiuJ66Ly5SJZ2zpuYz2LciFNdvdwT24RSEA8fbNFQFQCAiRQ4AHnVR0CxG0Iz
         b+28qIj9et6XnArjYlaxFyyHukxYaR4n6eB6aVOSBzXkx4GANCp7oINH8rAik7lo28wH
         I37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718449; x=1784323249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkO38/dlD5gJBLaxlIlRDPnanLV+lBE5oM93sK9WuLY=;
        b=Qci1sgrXsqeuat0pePQ9y+8Ge4/wQBtUelT3zYAV0CvwBVF8lRGBNeWLmNAn0UKlJv
         Rsszvc6n8j4w+NhFtBSCTqZ0qYmmylBxuSi6I+wzH2qX9D8DAhU9w+vJ0xQ37eD3nxWp
         ILJ+jlB+P3f3xordZgimkaq1HVizEW1Qc8jZo8XT1PepG+CLPwW3G+biqDPKTQYm1LZR
         WjXYdFV5qPXyY3OFr1LOMshYnzyMpKytqxTgJLMOKskr4PCkYOWSwqDg8MpZuxce8cIV
         OV8guDh6kGk2S5kH+gtSC2ZF8z9532F94Pt10Wm0bqY5tY9OaaMaiQad053MzB16j4C+
         kSoQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNPxsEieCzNBoIPfx8hnAz6Qso1KOIkzE5AmppEmtzIyMyqMAgZuqv/kUJoGPg/eLX4dhu1fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFJ5FharyVtRjJXERsNnAUMmQCFz1A88AlyXTEqzzEb39PRC7
	CZPAwHhkWPJAs7vKR1Abkgx0vOeBP67EzhlhgAa3fkp07iCcYSJnsqH1PmQAo222IJrCdpwdZMM
	gtQnM47G5keDP7wTQSigoU4e2tOm038g=
X-Gm-Gg: AfdE7ckQ9QQHgHNqz7+r+JxlfQzzpugT46lbJCX0mBr3d0T6MK7HNew2IxcGvW7Xfhj
	ooVFkODfQA2y9SmZrRDW+LK2c/I38iIy8mu9pArV45Tp44toaCOuJ2siAd2sI+fCwozp3nEgmD6
	7DwKhh/LzP5Q1aGDpAgnlvfJ15vazljHd/JvLjwaCVoNOpzrI4CX043DOxqETaRoiYcUNkTvKVH
	4HglFwBpBH5HapzW1DQK/Hmi0T32xythZm8wMuvWmbmQVVDNY1cU02eTW606fNIUpwNAzugTrCT
	ka4rzNsXhHbso4OsQinTGZeBKtI++A==
X-Received: by 2002:a05:6214:c85:b0:8f0:4e44:79e0 with SMTP id
 6a1803df08f44-903fe450e8cmr9311076d6.1.1783718448596; Fri, 10 Jul 2026
 14:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707065304.949135-1-nihaal@cse.iitm.ac.in> <e9ecb5d3-cb77-43b0-ae75-f15a28bc86c6@web.de>
In-Reply-To: <e9ecb5d3-cb77-43b0-ae75-f15a28bc86c6@web.de>
From: Justin Tee <justintee8345@gmail.com>
Date: Fri, 10 Jul 2026 14:20:23 -0700
X-Gm-Features: AUfX_mzo0Q8HKuQ82Eb_1CQeDvkaunnykMh2QD7BuZJBtufUgw5xnipZWe_KVRE
Message-ID: <CABPRKS9BUF84OuiK-FLfrN-z7t0E567Nvq0=1pjLNc4sH4yjZw@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>, linux-scsi@vger.kernel.org, 
	Justin Tee <justin.tee@broadcom.com>, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Paul Ely <paul.ely@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:nihaal@cse.iitm.ac.in,m:linux-scsi@vger.kernel.org,m:justin.tee@broadcom.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:paul.ely@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justintee8345@gmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273336-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 075E373ECA2

Hi Markus,

> How do you think about to move the mempool_free() call directly behind
> the statement =E2=80=9Crc =3D lpfc_get_sli4_parameters(phba, mboxq);=E2=
=80=9D?
> https://elixir.bootlin.com/linux/v7.2-rc2/source/drivers/scsi/lpfc/lpfc_i=
nit.c#L8180-L8191

I think you mean after the "rc =3D lpfc_get_sli4_parameters(phba,
mboxq);" statement, but yes completely agreed that suggestion is
better.

Thanks,
Justin

