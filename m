Return-Path: <stable+bounces-219957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEd2J3GZoWl8ugQAu9opvQ
	(envelope-from <stable+bounces-219957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:17:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376981B7861
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DB230FE8F4
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D561F30A9;
	Fri, 27 Feb 2026 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wcEt44fN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D751A9F86
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198214; cv=pass; b=BQLm5YzfOY68B8p/sSNKVV99pJPe4VoiObENkmkbHnAwiI+l3j0EFQEhaW+BTaXmNz7NrWg/ZW8HCoMv/hzUArpu2uo2HOViNQxFxtNy5A3owpy9gjXKqpDMwp7DMJBBQXodEKtD913UjeijNMxLNqMyIyhEq5Hr3gCN/CGaH2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198214; c=relaxed/simple;
	bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcBipR4oX1pbH3vof6T7lgG+oYbsbL3b+b9oAAsyB3rcmaS2X2S7HswghAM8SXuHMli+mcD/2mo0H6FVBz8IedIaPddM69x0SOQFP02Wsw7kOWYeB63UKDybWptbbFaU8MffOKk2HxFdREMbfZWhA2bpfjAqfvvEG5nDKTWFHas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wcEt44fN; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3590d548576so1139000a91.2
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 05:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772198213; cv=none;
        d=google.com; s=arc-20240605;
        b=LfDlwIx+1OH1Rbcg+3t1tZ1MyiPPz9TAX4ye/yXfsMh5yJSt4qQUJUpuLw3rD2IVit
         xlPGkf6elvFn/N9DUGM/ViKOSUUg8aoBU9rmuhH8N2Q9+2hg51ldMQHkdsbICu8JYr4O
         TCcqu5VEpDjWv7PcROFyGF+xJKgyaGSwTLbKpYAQ6muPuvOdC4/09dRSx93I3//I5oPk
         MjLOJjQQWF23jVHnfelKfPzZIAUrni1Sp9agE67V0PsGgakg9++958wovzYR9Ai41VxF
         J/q/lyRwLsZeBgQEv7vtsRtHPfuMRJ7eRyoWLlDeUHZvnwAOP11MPDIu4OnCT9tSIEKN
         SY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
        fh=F+aGxGLH4ubfLXqakq9YQNeJB1NHrIUUJgaPTOCEKbA=;
        b=d6G3axvHticIk9p+8YjapQW3SoFMKhWhfHgx4auyMKMpql4AI80TOryFBtP37g0I+d
         kzL2FxBJ/aPbDP/bJIDlzwSArhcUgQnY0uNAbd2iUlTOiRyB96wvUD3jictP/24Idkjm
         x1qok+SHBIJrBtuemVTkxPJ6+8e55HbaesYyv6HAdGyTxX3Ymt2NUwYfHGD+XIN0Zi9X
         bIyUOVibhOSYDim02dU40SHNERBOQKGZ2lv4cwT4Io0lM1aScI69MK4lRmEq0/GTxk02
         zQPPQDk7ybPUMKIwWJxsybunZjKOu8PCDX3l+aQBHIBlsLCya98eZ9l59r7zZzi27Bw5
         a3GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772198213; x=1772803013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
        b=wcEt44fNSYxHu4VEgpx6m7v0QIASghwvaT9qWQbowiOuywzOJKh3xLi94v1vhyzdpZ
         svL48MLuzhDCQVEo6qIKrMQNt3AskDm/Mj7/dub7xIiJU91Kpmp0fv5stFUVSwcbruV8
         EJzYVriccF3q5icnIoC2gLlRr0lw04VRK7DS8tPyVgZGIg1SWhM1UsWRuzLXSm3pT3qH
         kkPClft3zuP8EDWOSKes79GgHmYVoT01kPD1rSLKRAquq6L5xjlb3MADnjASIvqyLo2O
         aIYHL9HoFnZcGOy+RQHnHP5RqmjF1Is9GdxZcC5c04yckNLbLLcUNRzBnycW5Bn88oym
         3QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772198213; x=1772803013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
        b=NYpDqHoUnLJ7Xp69gtNRpAGJCyhLXRujW35FL+9XqxvnM9ldyBPejkqCLe3DsvlLzZ
         V3IEUnUfBLnudknR+8PEyX4H3IJMxq6Zu4CpuX5Iu/vjBj+qzcuevn9ywir37QW/DFZk
         ImHiH4d4WejQJk8AvEIjWjm2IsIznOCVf2AY0CnBc2mJwYO02XM6nC1kTGYsPHFYvK8A
         GXSlsf9WXovi8IP3JuV9AAkE9HFxpvFmdNikEfqJ/QldkcuNMwnksLYMWrMcx6WhDeL9
         3mV8NjthRR+Isqz+tOqqkHKH19y3z3GTcRUHJxwqt5kgj4V447bP2xy6zpsSWlcGZUah
         w2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqPPl6BKIYP8601/CGn7vn5KtpOHt79EuItg24qXDmGQzo9Eb5rU1j11UrielR8+CtIrGYLdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YxTGPH0HTABLcTxBYl9fbBj0qpYR7n78viCQmGcitnl30IV9
	n+4M3ke8XjA5QMWGZVGLuE7uKpFcDuaY0I2UCqwsWwbg7dHAhYVs2/oTKl8YCFJo3WrxXSYS0U/
	B6j4sEwTrUxBvBlL9LOvO5R3M++xfjYZS3ln9pCH3
X-Gm-Gg: ATEYQzz6Dq3Dx8rJHZOp42L+EzmbZljM04UV1Hs+87R0fKBmYpgMSy5zWJtkVvymzll
	dqh5pogR5eFu2qgJko1wAX9U/+bB99FR62AHyZTGtitY/7mGe4ftPkUvmf81wbbdMJraWpkLQnX
	+BMnvYbPokRe8r0cwdViS86J/gRdKQjOqsO1j/5Fql40WuR5cQGq45sS2BZzLQ0qD1zX/hCb78I
	anIFBEKmW8np+iclYeMn3B4g/a8T2XG9OIU0qO/X85Isogh5R8d6f7q1BilZTRrCHSnPTLwVTp0
	jzXaj+wnpZyDyl4=
X-Received: by 2002:a17:90b:38cf:b0:356:2bda:a857 with SMTP id
 98e67ed59e1d1-35965c9d127mr3060071a91.18.1772198213005; Fri, 27 Feb 2026
 05:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org>
 <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com>
 <20260227013151.qaw4hvb4fyt5roeq@skbuf> <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
In-Reply-To: <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Feb 2026 08:16:41 -0500
X-Gm-Features: AaiRm501mvb8cKgXrBcKkwVqLRI4xO1kMuzIWg1rjrI6m_S9GMPSEI5hVakE9Uk
Message-ID: <CAM0EoM=jY=w7Chj1=oecLfEkyXgbydX63ykywbXoYHrCLafRoQ@mail.gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Victor Nogueira <victor@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219957-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,1g4.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 376981B7861
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 7:07=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> > The ocelot/felix driver doesn't offload standalone actions (TC_SETUP_AC=
T) so it
> > doesn't notice changes made to the action using the "tc action" command=
.
> >
> > If I make changes to the "tc gate" action parameters using "tc filter r=
eplace ...",
> > then I trigger the "The stream is added on this port" extack error in t=
he offload
> > driver, which seems to not have been written to handle parameter change=
s very well.
>
> Thanks for testing. Just to confirm: unpatched kernel returns the same er=
ror?
>

Yes, it just means that Vladmir's hardware doesnt like replacement of
an existing rule, therefore it gets rejected with that message (error
code -EEXIST). Yes, the message is not the best it can be but could be
fixed later.
Thanks Vladmir for spending the time.

And for this patch....

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

