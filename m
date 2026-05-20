Return-Path: <stable+bounces-250015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKzYE43SDWpP3gUAu9opvQ
	(envelope-from <stable+bounces-250015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA9590C75
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB7203039277
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A33EF0D7;
	Wed, 20 May 2026 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxjVXlqU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB933F0750
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290346; cv=pass; b=KNKSHpm0tMg+mwpOCv+jbtQUKcHuvv0xfniVHbHjWm5cwzF7i+MgoP2Fzr3RLehnRKcbd0n3llgSW+D/rQkjd1uRJtQ2WhEZLqm8OOCVHOrkFX+7lmM4RaNxztcXic2dLO2lm1GVMr4/3vOE8HeH90zMPne9yZfOv5px3I13OYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290346; c=relaxed/simple;
	bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4yfasOAM6hSJK6ablAqRHPjT5w95AEl6UPLvC7ALLMmWpcaAES0w5bDcj0GTvDwLDbTmL4AAsDbgWxebYzc8SE5sp8Uluxtv5v9S+KExEx1h5C/gbFdl0Es8K3chXsG6J7t+ovAnU9Moyliz3G+Cq5SbUD1SdSaNnNfErjSbZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxjVXlqU; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so5073829d50.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 08:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290344; cv=none;
        d=google.com; s=arc-20240605;
        b=ASn6JuuSU+qRiGiErkTk15HITZAvSLajfjudnWrxjhYgy/wq0QCJ9r+LnM5ejT9NBb
         /iT9cO+jtqsQBRTbFaD+Ai+TeBswTKswJ6skJOcoeBSLxA7NYnTWFWKWpZYVsn5sTzRY
         tXg/h63d0ofGDU36dp9Kw1OLWjOVTgTWvk9292372aJXYwyAMEn2ToazYNOGJ6os9PYa
         t6zOhRbG6dwrp1XVAQZy7Wt8Vf77cmOaRjykNTLBDW3NtGiIYgFPPaXWFuAyQrB0mfAE
         XoFSqktPqLVheNMKSNslbQWCZi8FTPUDYHuutcXBHnNkfvPVrTBfpbV/2WdSeq3AKRkd
         hetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        fh=hVhM95r8IkvSI5tBw5OVpGgWbcuWhe2qNjN2f7FrEmY=;
        b=PDDnUD5zr8ZfshxmSf8YWu83uPQY11JAbvH4hW0qTNRrbRGFW98m7PrHHOikELimLX
         0JeC/czS/lu3VpSZRNIEu7NB6fd8CRuHAeRvfLTs3Vy9saPHassXtAz8EC6Borihkq5q
         YGr6zSeSiNM4gJFZSwdNjf9SarGMd6TlSTbayTe+holmo1FOW3p6oIU5uGapZU5XdJUw
         lk1O92SOZ1fag8Rb83VWvgip4qqGrfpN7zR8BJbYl1JLupg1H3ID6+CdpVTuSUIUyt3B
         pXcGmGmoN32dEn7ybrDdOFvEvf11OKEz5T3Nlv3gfc/Oo3sFy9l+UjxwUQh1VUu+mFX6
         sUSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290344; x=1779895144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        b=qxjVXlqUfdE03SRW71A2N06iP8qP5nLqeN6pprEDdnboEdVxgxQErzX37k47E8DT0q
         X5oXGoqhul/7ct506GVTNshptUrlIaciwMqm+bdopsNLktt1Viz5V2xTn1h/4+uQMOXD
         wEcaloOGdcmHRIljdy+jh+minQ271pk+h5FaTk86Q/xGaUHRRRKEuw4eXb/zjz2oBR+T
         pVAkqiVsSwixBdAMbIzlPFf1zp8M2LVxOLcdfpaSgBA6Vf3LnHbT7sb0+OyltHeDkOBU
         VYpLwUS9sm+j+KRiXhv040QJmZgnstR9XFZdp8yFggvx67Qg805i8UGet2AGwOLQ9nSA
         boLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290344; x=1779895144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        b=sB+kfiemzxuGEyqFB1w3F/EM0BI1OUbppZQgddnbm48LEco4sX2+B4n5Vn3C5DqaR4
         etVfjUexjTJgp+6r5KIId9qnwi9Rplg6YdixAMeGYpzdvj5gtmKW0WV2/48MgH4FPDcY
         lBU87CjU+HYJ5xdcZREWN+skNorJ6rRHkTZ2FGnmCyqvJERW+8U2hJbpBzden2p0RB7I
         Iei32zD1ws1IZ03M62V8asg4LAaaZE1KPtaotpGz5X8LWoakxAe8uYqa9ekATQEZmr/7
         TM88Bt4t/7jFmpOhzpRAcMo6I1glS87pb0u11tTfGMo/DgCJc5fBHgi4aZB7O0i/tCNk
         yoHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jkBkibS3DFmVvGRmvulGWsqieZq7Xg5LaptSkLOJMU4cav9CEIaaRJeDusiPKLmxw6yk0rVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuE2bncyT3pbIgLMerWycgta97owChQgbPc3wf+K9gt1DGWhie
	IUaJwGkuiudDCMOesb4HETsBr4go8xTfErngrlx5FOl8KZiS0NlDUS7mnair5BcpSGt2DBsGhq+
	AU/Jic+pZtrtrO11SgHKhvdhf+RiMjhw=
X-Gm-Gg: Acq92OF1/S33kGJO07LUi28CurH59mBjj6j5kWRAmIyJo0+ujAU1akcQ1WWKS/dtD6C
	MUy/JWcDAUCBM8wUr6rudly+sZy2C3ySJRCtLraJiU23Yq4DipALHs1QO4nx9LtzYgFXb2IwvMm
	vv2ZxKfGg7rjzjxgFN0OtbiZD79xt8f0ZH2ASXawKiXhlVXmHfvnsbf1CR6o2nyMKRP8RP5/VMD
	8NZ653FtU/6H8F7HohBf5ZXkfeU+ln9y0h8SEA/PB1u/9aKOaNCvqs/nUxXK5dz+UbQcgWjkBjR
	tIUwlt3lQG7GkEnT9tEbAfa0cOJbhhI4W7abZNdOE4Z/Xj6y3G8H6AghfeRDpEMzRGgLcYD4VHx
	lYA==
X-Received: by 2002:a05:690e:250b:20b0:651:92cb:7157 with SMTP id
 956f58d0204a3-65e227fb576mr19553117d50.36.1779290343944; Wed, 20 May 2026
 08:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com> <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
In-Reply-To: <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 11:18:52 -0400
X-Gm-Features: AVHnY4KnSO7nh2Mxl3gO31RP70GuHBlFZ_lZE7u6YBzWgqLDOxXw38-nlAPr38I
Message-ID: <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250015-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 36AA9590C75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 10:13=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Weird, does the AI come up with this? The id is actually _not_
> > important because the error code will essentially indicate that the
> > entire packet was rejected. Therefore, it doesn't matter if the id is
> > for a request or a response, it still needs rejection if it exceeds
> > the MTU, so this seems overengineered.
>
> Yes, and I debated this with Claude, but it convinced me that the
> lifted helpers were more idiomatic for the actual spec and bt system:
> "The identifier shall match the first request command in the L2CAP
> packet. If only responses are recognized, the packet shall be silently
> discarded."

This coming from the spec is priceless because silently discarding the
packets means the remote stack won't know the responses were
discarded, causing the stacks to go out of sync. We also shouldn't
process packets beyond the allowed MTU. Therefore, I strongly disagree
with the spec requiring an identifier on the reject, as this implies
that even if a custom MTU is set, the packet must still be processed
if it exceeds that MTU to find the first request command within it.

> So if we ever lifted or refactored the code, it would be abundantly
> clear/safe to reuse elsewhere.
>
> There is also much shorter version that just peeks skb->data[1] and
> exits early if not ident=3D0 if that's what you're going for.
>
> Just let me know what version you prefer.
>
> Thanks,
> Mike



--=20
Luiz Augusto von Dentz

