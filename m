Return-Path: <stable+bounces-212804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DBBNpqbe2m5HAIAu9opvQ
	(envelope-from <stable+bounces-212804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:40:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74777B313D
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B465130164B7
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035A353EE4;
	Thu, 29 Jan 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soyRwUac"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B81340DA7
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708407; cv=pass; b=O+Ijusw3lng4oWv9dNMP/K7IL92dZawribTULgJyTIrGzxjOM5qe7Cu3rVPKICNuXfjiaJ7M6g8dbf5mUiWX/TlMTP2cUsiz0huuXG/iejjU1wvRxA1TwYEuSoGrtnK/FUczZAIgqo1WFq6v/4X71nm+Q2J5nyn+rVOtAEDG6Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708407; c=relaxed/simple;
	bh=WoM64yTCNB7JYnEmUR+2RQGgCYwp8/a1dcVHbRqdJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHLikUzDwYRW/qgB024C7arqoqXvXzgyvQCRz1o6zXfTzzfXqFL1r/rj0QZzPwEDkKzRLSG3fBwTjyYBEVskfnieKvUw6KkbwGpudNWocJMDAGa19MgM6GaDdVG20EeIwWrrFHpkGAPACgk29XqPZrZ/+2YqUyw/yITrYMgk2ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soyRwUac; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59de3f77d2dso83e87.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 09:40:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769708404; cv=none;
        d=google.com; s=arc-20240605;
        b=SY8DTK7IGkbr46gi3MaxmUJalJqebqwNXUmW5rEnWVvdhab4Xge5IL4JYx8ddftJNV
         eLbOj/VdqcEg1RFtx++e6Trxm/mmkrQ/Vbi+8WdwKrV3Y+zdVWCij0kWQ++7FXX5Sdul
         hKfVw0W0LBTxEYu6JquhMX5V0zGPiw99+fp0aRb1tWI1zftzKXf34XIB5zC9Pwpm8to0
         wZjFZeBcCHILtxSX+mfVvc0nCV5IifwnDGjFQibCZFZI8lZPwUTdLuOxChgwVVii6QiS
         PxLlw0Q68T97UJOyNIzixjZ3zArNLDHhiyGsIeViveih2wyEhtEy6HW4bgyOkGQhG2Dc
         EBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WoM64yTCNB7JYnEmUR+2RQGgCYwp8/a1dcVHbRqdJek=;
        fh=L5z6z71qM6VZNS5lC6n/EQwrn8tjiEcut5okXrNN684=;
        b=RorRnkvuCKCjFLfc0B4fDVI9Tn9RKWBog53ICZDmLpGNez/DqYoGj3hMsmFd16EUk6
         fzeJQ+wx2gLQmC5+qT16XW4enHl4PG4o+rK7eA23/aO9ooLGKlajblnZEwydRz54RiYv
         MENfrC5KW00ffuYEX/lYmJMVWBQpVbiKyWBByMU6ngKO2zpJovvI0h57QIBxxzphbHyD
         hqgKMTdPbzXHFbi5rMTCOF2sMmezj1LChSD6Aeq6GWmTrPwOJMnyE1JImkp6AIAK7QQ7
         Zpu0XrnkNlJvOL3AvwPHx0RURUZxEEW1bYkKXOACiW1IJ1xeL/dGUqzumhxB0EFt0amB
         v5RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769708404; x=1770313204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoM64yTCNB7JYnEmUR+2RQGgCYwp8/a1dcVHbRqdJek=;
        b=soyRwUacE5+/d0e1xEvLV3CzQwvRklUgZu+07GCR5r6HWPCEcGPgNAwsyje7XAM642
         9WUS3lZda5f3vTrH01PbicEy0xRYVAVabN63Nks1UQ0sDagNFW3YaIEubznbwPJrgoSP
         3Pc2ExKHKNIwplB5vwCN0citQkrpJutv8v7RSLL97RVIFuFGZaacTrKRG9BGlz2V3gLs
         5OzAFINrUM7vvNS0CutWlx6ATilTDDr1Q98bwtWkjIFk750tNQNVONDMm+fjB5iy+gFM
         n/KBsc0bPGAssm48so91Lihz/DNXIeDtVVRpHpGHQDI3aRYVTn70fpoq1gpD+FECxVF3
         KVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708404; x=1770313204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WoM64yTCNB7JYnEmUR+2RQGgCYwp8/a1dcVHbRqdJek=;
        b=pQF/oE32vq33DdcKXLdD7H2XHR4cdhddzpnj31gO74sEq5kmdw2xaiKpOF/ybt81aL
         8DOHhXVVkk3osxTuZi9JJnMr1NjeDVdwfnfM9d58Eac7nHy/nXxkVkSTs1CP8TUU6ZGc
         QNOwvpj1C8qlTQODDz+Rw2jqHPEUPBF/w5LIzFlrtVCmRlVToBRkF7GjqPFIEYBUVgB+
         86xeydkk5TVDsL5VAWtRIjGRWs5RCC/F4AxkT3TW0jQxLlpKnA793/kGGYs1LKf+De+u
         afLofG2Pa3RO/uyHA8UccwHBXO/xVT/hmLd9dZw0sT4ZorrPOvFpXE3aO/hfjhv4PXnO
         fRSA==
X-Gm-Message-State: AOJu0YyJTvZ3LuGG5JRx7R04sIORc5Lgswlwywp+oEohiWVqNz6BX6AM
	PA5g9ullliq8YtQ90FufUPIPyPGj+Aepi6i6AuLEf+1vC5Psld/NrbUKsaXDB7q5zNtGzhxOe2V
	b5P5t+yF/nuJT3RZHip8hfKRwFIrygYwH4HAX7rk4
X-Gm-Gg: AZuq6aJoR/3Jzte6P+6BJv0N2eDzZbAf48NgfgN9zsINibz53ZkNZZh+riVd9qTjECA
	uHgh5bkWrd6qu8uh6/5WLN7V91z7BbdiFTELwxPXXiOQxUPFFs5YkB3LnSPJpC4t9qkgeRlcw60
	7Z6+h3h3+PbkLfpuCE+VzhPlC3bRxvDIJ7D90FTJ9dyDP4Ajqh+FMBNvruseTd2sTVsU59zhVlZ
	NjHnZ3VlG5ximIpqlDTg7D7cBLGsFUWnzfht4wmP1BNV/7kGqQ7y/rmy3BFkD6agc+rgrHbWrKz
	CoDy3ezYIa3nal3NoE9GQAU=
X-Received: by 2002:a05:6512:67c8:b0:59d:d4b4:97c7 with SMTP id
 2adb3069b0e04-59e0e9eea13mr143439e87.10.1769708402489; Thu, 29 Jan 2026
 09:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129070657.678532-1-thomasyen@google.com> <491d53b9-a110-431b-9a5e-3b46d833fdbb@acm.org>
 <CALw5pqG735L-6-umZspQOKB9DfRHf7D0AfpkRD_=xwX0LtZ2Vg@mail.gmail.com> <076fe171-6fd3-4dbc-9876-242905379594@acm.org>
In-Reply-To: <076fe171-6fd3-4dbc-9876-242905379594@acm.org>
From: Thomas Yen <thomasyen@google.com>
Date: Fri, 30 Jan 2026 01:39:50 +0800
X-Gm-Features: AZwV_Qhggi4K8iOK9JRp7-P2bluiHLmE4haFJYoFWzKZ5xvP88OESko2o3VKUME
Message-ID: <CALw5pqH8LDxxHcpS=KGnLtdA0GG7sdd1y3Zz9hQLfcChgyH+GQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: Flush exception handling work
 when RPM level is zero
To: Bart Van Assche <bvanassche@acm.org>
Cc: Stable Tree <stable@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Peter Wang <peter.wang@mediatek.com>, 
	Bean Huo <beanhuo@micron.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
	"open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212804-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomasyen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Queue-Id: 74777B313D
X-Rspamd-Action: no action

Hi Bart,

My apologies. I missed that Peter had already replied with his
Reviewed-by tag on this v3 thread before I sent v4.

Since v4 is currently bare of tags but the code is identical, would
you prefer I send a v5 to consolidate all the tags and fix the Cc-tag
ordering? Or should I wait for you and Peter to reply to the v4
thread?

Thanks,
Thomas

On Fri, Jan 30, 2026 at 1:23=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 1/29/26 9:19 AM, Thomas Yen wrote:
> > I had just sent v4 (to add the missing Fixes tag) before seeing this
> > message. Since the code logic in v4 is identical to v3, I hope that is
> > acceptable.
> It seems like our emails crossed each other. This is something that can
> happen.
>
> When reposting a patch, Reviewed-by tags should be included. I don't see
> any Reviewed-by tags in v4 of this patch although Peter Wang had posted
> a Reviewed-by?
>
> Thanks,
>
> Bart.

