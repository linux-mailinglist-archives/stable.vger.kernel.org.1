Return-Path: <stable+bounces-215414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFhFOSf1iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:54:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C71112F2
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7879530406BF
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59937BE8B;
	Mon,  9 Feb 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNQcKWJT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416E37BE7F
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648715; cv=none; b=HTy3H48ITdcI+jx7KpESESL0AjrOJ7ZM4+UiB1AOoQTwE8GEiQfTbtWlP1JoI6xo9X2QeynQXJMDfCQqvI6+maUQxgPZhGSlW/W11CSAYgkKkMAOhrVMmeBdz8fuMEnRmx9b58X9heciUm4Bq0Y/b1JFNzzCzQu9JUqs28G0dBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648715; c=relaxed/simple;
	bh=lcaV+/NenUzIzdCorLQUAbikrOG7FUJR7yri/AysGyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edst3WIzuT5SG+yBk08DV2x9bhWeC5sj4f0JPLth25G/gfG+FNBSJJrbxCnOT3uOdPQRLq580Za/Dgfx+1tKa1RBo0PTzSRnykHRCUuarYQvjA5SsrhOuBD3suS5WNNMw7R1qEuw2tSJaTaCfw9wguk5JxMpeAXgDRGh3pPHKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNQcKWJT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8850aa5b56so791147666b.2
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770648713; x=1771253513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcaV+/NenUzIzdCorLQUAbikrOG7FUJR7yri/AysGyA=;
        b=WNQcKWJT/XzYKcRzT6H09eqeQoo5QGEvB3qwX9xpXcRdbnHhhTb4ph2IojBSE9hH78
         HhvQrshjolTVWcXSo+SuX241gGayjEsv+8rt+FpuMSXr9V/eWBZcHvfuxuI3pUdZHByr
         Pb+ZvfggPPCB8rEQ3eKWWgFzonWNxKhqDkIESY7ysqMH3vJtIFqssHHs4HX7z7ARGLEQ
         2T2656Z9SVF4zW6CgcGzMRfHiYEh4um7aNjXOfXZ6FGPjiJPr2O/ukbPnWAY2uWiUBxA
         k38pc7PLYVrFw+TS8fr2Ovwqju95eNyDLgHkRvhE2UalDCb1ub2jKzQSzPFQgHxcEe0S
         h9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770648713; x=1771253513;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcaV+/NenUzIzdCorLQUAbikrOG7FUJR7yri/AysGyA=;
        b=Ox3wjrN1W1kCXGuLecUP5FDs5qB9HErh1qlEzuJ48OhptYgteQXG1m7uERrWGUCSh5
         mU6ZnPbO6cYKBHRy0Ji8DxWyR4toa/hKd8na8wOAbHMGG9wl94Wq3X4To24SjsKBaeaq
         9DO+gqszKWLyoCfNniMHRaR2Cs1sXYpf7L26V/9Ieh0EoWWTuh59XK2ox3QG5gY5D0Tz
         hLBtf5gfS2waRebWUC46X7EVQ3lksimXkmVS2vPhnO701AiVde46NsVzLHdL9sHkts9t
         4qWITaXXXZXrW7p70Tc2XiRveUfMEeTdCFDTd9AcpkTLc9gWiPbuoay8uCS8s0eLaNrM
         U6vw==
X-Forwarded-Encrypted: i=1; AJvYcCXkjMAdwyJh9DBGBhmY52AjToKS/IQ+BK/qKOaDyPHZIwd4IGe0lQurC9aY8FugwsdV+mBC+sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxowsA6Fr4S2Pj8QPiB0FgQFRs+aXbSgYA9DvenMVy3pZBvFWli
	wIrXJ5q69KQclW3BX+0zq2dWN2bOTiRGxsubV0FDeQWeYxR+WelfdZrb
X-Gm-Gg: AZuq6aIXlVfiN/QsRXsCH4H4JLwsfHhPu5VT75fi5MBuBsTkZsLy/2xpVq+Hu5jJubK
	3wGR3H15HEbVp4d31MNaChfmUlXyhpAyk2RLl0wGBetyRpNt0qqpr8luTW4HYtadTjHAGf5xEWs
	rEH8e/+6KVR0I6hZB3HwcRm8GFucobXTzMNHn5HkA5HHhxMnlroNzWzA3AV6Sqx6Swz2Kj+bVLr
	HPgmJ4N+IodVtiXyvJQJP6DL9LNfpPJQb/Pogrq40TvHmnkDWI/91RQENDp6tHNgC4h2NLtS/RM
	ZDbhGC/3mC/toTnHH1oOGLj+fO499T0Al9xocEdiTYzoPDU9BStWh8Dqt8b6yrHB42DfYRsO7yK
	4vAKLnh5hQxwI3LT+cjtEz4VF2goUDsHBPD4cQicpIn3Y9m/jjCGW4lIaKuzvuZOykISjZ+QbPM
	+PVT8+twrYhxg1ig==
X-Received: by 2002:a17:906:730d:b0:b7c:e320:5232 with SMTP id a640c23a62f3a-b8edf11b357mr695742566b.5.1770648713193;
        Mon, 09 Feb 2026 06:51:53 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a5a31sm406314366b.24.2026.02.09.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:51:52 -0800 (PST)
Message-ID: <e96f69b108eb13a87838581aef9325dd74c556d0.camel@gmail.com>
Subject: Re: [PATCH v2] scsi: ufs: core: Fix RPMB region size detection for
 UFS 2.2
From: Bean Huo <huobean@gmail.com>
To: Alexey Charkov <alchark@flipper.net>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Avri Altman <avri.altman@wdc.com>, Bart Van
 Assche <bvanassche@acm.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, Can Guo
 <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 09 Feb 2026 15:51:50 +0100
In-Reply-To: <20260205-ufs-rpmb-v2-1-5e1572ee52bf@flipper.net>
References: <20260205-ufs-rpmb-v2-1-5e1572ee52bf@flipper.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215414-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huobean@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,flipper.net:email,jedec.org:url]
X-Rspamd-Queue-Id: 6F9C71112F2
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 12:30 +0400, Alexey Charkov wrote:
> Older UFS spec devices (2.2 and earlier) do not expose per-region RPMB
> sizes, as only one RPMB region is supported. In such cases, the size of
> the single RPMB region can be deduced from the Logical Block Count and
> Logical Block Size fields in the RPMB Unit Descriptor.
>=20
> Add a fallback mechanism to calculate the RPMB region size from these
> fields if the device implements an older spec, so that the RPMB driver
> can work with such devices - otherwise it silently skips the whole RPMB.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Section 14.1.4.6 (RPMB Unit De=
scriptor)
>=20
> Link: https://www.jedec.org/system/files/docs/JESD220C-2_2.pdf
> Cc: stable@vger.kernel.org
> Fixes: b06b8c421485 ("scsi: ufs: core: Add OP-TEE based RPMB driver for U=
FS
> devices")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Hi Alexey,

please address Bart's suggestion in the next version, and add my reviewed t=
ag.

Reviewed-by: Bean Huo <beanhuo@micron.com>


Kind regards,
Bean

