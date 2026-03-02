Return-Path: <stable+bounces-222609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CKsKZGbpWmfEwYAu9opvQ
	(envelope-from <stable+bounces-222609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C61DA81D
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2813B3066E48
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E923FB07B;
	Mon,  2 Mar 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGA+qtgg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C13F23DD
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460657; cv=pass; b=ID/u4anXiLkZj5oUKOZfK2qBNtepHROfxYorO8lHgeJuu/rFC4cjDnD2U3Lync/yrBAAucoSLd15QkV9GB8UF5PgjYexedxfj537PU5OsaybGdWqW4OEoyq1gj6uQocuqMMwoYv5QEsGsyMzWOr81cjwI+5GOx9YWvDiiJnc/K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460657; c=relaxed/simple;
	bh=VSmCW+61Lhmj4XIWfBlzKJ3W//t+JZh12/qS9o4XgQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZneimBboAMfKjbaFrOtC+MRU+uG4XB9ZboLft0UbALnyLoOi/1pXMKqpEXewPOLK4U+xhn+CwtOpsPIlgjj0tbBk9sLmZ3OXws5anhpnt22wMnKfz5tlWkQxT3c0+IdxaZnjnftHl99u0xFWBrbkt0Bga1d/15wrzLEOakcFTRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGA+qtgg; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12714f01940so165729c88.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 06:10:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460655; cv=none;
        d=google.com; s=arc-20240605;
        b=ZzM6CmnVTCsw5ASrhB+QlmLmfMGG0V9a2oQPanoFIZo3arD3pqUUI9hP9EEIZhhIL0
         f5D3DPAySefRY8o09DnPSj5sFbsqBtZGMIdZvBLSPVmyywjT58eoWUmt2oHj58T/g/lf
         NSJyT7e1a7ESDrWDXWY1Z2MF2wHJCk1tHzG5In36FLLCg0ltrd++OG1K0PXhj5V9KUOy
         Itg9x7kFMbYaXeVOtSSCeWDV9A0kcNOOnOO/a9XoOkNClW5xd9rxGaK5uBWcSRJ5kcrd
         kdMsRiZD9SvlCwR6mcreeK4nf86uvNYBuVFd9E0LnBe5VMBqCY74KWO7554Cg6XpMYk6
         xGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSmCW+61Lhmj4XIWfBlzKJ3W//t+JZh12/qS9o4XgQg=;
        fh=T61UVwwVfTDva0lsH2hU3qPlEvCHcMdcWJIInl0GfDA=;
        b=NZ2KebQ7GZg/FbQcAFPbjE0YvrcAOovVia8hPVDNyX8Jh2HzyQDYw4ddKBD6xVwpbi
         +/1pQt+6Qp77pslhuFIvdYm9TiRFHQ5ss1U0k7j+bqStDZKBzt2Nd53W7GesmvZSF9Bq
         UYtb51jOvY7ChLCcH0L+RSt1zIORb5ciBfzCHJsXGz1l2h+3Ju94NuyqWSWu37uOwT03
         O2zq1oOp4UA0b9Cqfsb5YquGaUWJo9WU3x0//SnPZrB4Wpb6KonG/RLoCx67tSNBw+Jx
         e3S80zvMoxqsAKxMQTIGj1RmniphsQ9HecPiHc68NTYEas9RxNvFHM/cBBeV/qS08VZQ
         J3Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772460655; x=1773065455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSmCW+61Lhmj4XIWfBlzKJ3W//t+JZh12/qS9o4XgQg=;
        b=VGA+qtggoL3ZgeAtPzIPng+d74C+DOBF9Az67CQMrS/rNLVVpoDOxuf89pP0s5id3O
         r1HIdy8T5Q24h28Pn3XNVr3XkBbC85FI2NYo6o/VffsuwwjTjMYqYBfXe/qC+VaAvNvQ
         HphGvBM025NrEtOzeHhrOi4WpJbHxVNSTY/Byqp890VDyOMZaXbfD1nz6WJKTPHM3H+M
         l7a2e16VB3PuxWvLsg7Au0AQxjyDSAr630LpQw2TvaNy9CWC95OFV/59csturpDyJ3Qd
         A/lSjKbTxkIL6OJfbYfi/4yx1WMS2WyCxsn3vUrg4GAVEJb23ebOamiJYXpJ89R5S8hc
         Ootw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460655; x=1773065455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VSmCW+61Lhmj4XIWfBlzKJ3W//t+JZh12/qS9o4XgQg=;
        b=HLaEnb+ai+2X3an8mLXdXn76lY+MZyS0CsM3qEM6b0+LEC5tu6VupiSt195mFDmJAE
         vP+X+DPYYVrQQEX5lkx0REzTbUSEz53tdqeeKmSQQu8zCHYyMe0n+cTgiP3NDoUhEqcS
         oi+8MNxaLcumOZ6e7KAU0E+LcTmLZ4brQvWLqez+bmjoIgbJMd52hqSLx8msPoitGV0W
         WnCkCGRa1V7e9vAVp2G6WuBN0iUB58LzGinQ/1V8tXJks3YEYl7xra5HZ3l7mp4x201L
         TFZkf6oajTWP+8Uw6Z0r0OJrSLDWWxWiDxYM4GEsiwVOzORweCWwga+7sxUZ7sr7OXkR
         9uYw==
X-Forwarded-Encrypted: i=1; AJvYcCUXuGwOf+MCcX0ZiFGEdwGFLGy1VUQ6JGrxuRraDwGdg7Ir7si/47NxC+bansboAxLy+tfqeTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDBmTLE9OMrKdTTKhHCknr+Kxw+dWKbvZ5RVB9w6m32pcTuUG
	TznBZ5FcbBKldZWjowUOmyb117IMy0Dy0f14vjDBeomBazud/0Ui8fD+IQVcOY5YsaTGH7GdLq1
	PVNyCCKEtNqrTiedxq18HQKPF0414UJc=
X-Gm-Gg: ATEYQzyGVkCZYT+9wGSTsUIVJjQWqRi/4EhSqsNgrzOhI5dr86Scbd6Psl4yLjutHEg
	zVwjETQeeBZTbV+aqsO0/GRkraVwrQc68IKbC/ZVkYcRTCfexHpydcdYZd6iPcJ5dQYjkQpp1OE
	jkG+YRuZQW4qaGWrI3GgWMHoSzOFLzV9apEpu4mcdnTnbF8c9g13GlDIa07DWTCxBmTbd+olefA
	VDFn3Tt/Rk+NiGB21fUPqB8nPytAqrZ10SXWVV+9JaITSoxo4Ge2OXfDuL1krhPsse0vZxYxL9Q
	0gHCQDK2srAAq8GyGaPbtj64oY7Fv8JWhIRFR4uzyyWZTiNEM+olyujl2f1lg/oCmB8/wPKYdRB
	5ReKy/7to8diUJs2oxadEBhXIJbY4xgkvBcjHAGU=
X-Received: by 2002:a05:7300:5711:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2bde1d22f06mr2643940eec.5.1772460655119; Mon, 02 Mar 2026
 06:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mESZc2RfL2_5wt=LEg6M_7TZ__uELZ2tN=XGwB5Md_vg@mail.gmail.com>
 <aaWZQ5JG4ndWDxov@laps>
In-Reply-To: <aaWZQ5JG4ndWDxov@laps>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 15:10:42 +0100
X-Gm-Features: AaiRm53ixfgWir1y_BdcLn21kFYfEMBjpfrKy9Cr9JCiqLZ_WB8kWvhV1wZT0Bs
Message-ID: <CANiq72=4B_HrbO8+U3UR8wS-5eC43=ZqF-=aq48Kg_LEJxMUaw@mail.gmail.com>
Subject: Re: Consider applying patch to 6.12.y
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 091C61DA81D
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 3:05=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> It's already in the 6.12 tree. There's a quick explanation of what went w=
rong
> with those queues (and caused the FAILED: spam) here:
> https://lore.kernel.org/all/aaWWE5uQqz_eG69i@laps/ .
>
> I'll spin up -rc2 with those missing commits.

Thanks a lot!

I was just reading about it when going through my regular quick-read
of the testers' replies for the -rc releases.

Glad to know I was not going crazy with the cherry-pick yesterday and
the suspicious emails. :) Taking a quick look, I see others also
reported the strange FAILED: emails.

Cheers,
Miguel

