Return-Path: <stable+bounces-233817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE52FvkU1mnwAwgAu9opvQ
	(envelope-from <stable+bounces-233817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:42:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4DC3B93BC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8420D3007ACB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156DE3A75BC;
	Wed,  8 Apr 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfVqHMZF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAE385502
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637745; cv=none; b=B7ZrLIvPJ3+dM5vIhmLuyH96mZk2YjvcKnRCOr1LRThjafbsTOGpZVZQLqzE5ir1dpMfpcOEGxayjWgFG1svg+omiMsOnjTSxKf6OWC/0/KMm2MsV2dvJqfi/AQDKEpgRZFB6gWAzzBsERUmWIzjMeq31neJlHHXLSh4qflEz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637745; c=relaxed/simple;
	bh=P1mwUTP9+C5XapO7898GCG4IFtJ3Gc52hrbBGXsJznc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNXHksmV9vTURkSi49XFMmvK0SFZD2VS72j/znZzbV4LdSC9N6QL9MjDS9G9ZG6Xp6HJ/0U4hGfbNp58A2KuIXddqDtnkeBsKswdWcMS7XlvrOwngeaGq+AnLw+Y4d7xTx9rcgXOZhV76x6c1U6lOr3hKVbJdudTQz9gffjvT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfVqHMZF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so27682765e9.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775637743; x=1776242543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjb/JRkzLAit1h6AHpe5PnGhOOOcnvsE/48DReCWjxA=;
        b=hfVqHMZFAg69GFcWs6BY5ZLVreFJVTrMi3jocKIBJjoMqNIOinSL9OPVgZ0eywy/k6
         Df6L3HQEBSm2KS/z6bRsBTVbTUrvXc81D7TVVj/u0PhIDCCbVQh871yoFM4C4Ft/IlbF
         UCzak25bIfbrMeEnZ+VPJbgoXFo8DIm4Ji0tcLZOkYkOs9fOB7rTm1Mh5SYEgmIcpPJU
         kId2lrq6c9Lf5zBP8JChc88tFJ/fhMp1fYgHdn8nABr9xSiVoz+BZ7y9LmophrmQRebs
         549qWbazzMNKXskJWuOE21PGTvuN5fkSTfynO/5jhMXz3IereBfS8SZBjwkzqn9bEwa9
         sjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637743; x=1776242543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjb/JRkzLAit1h6AHpe5PnGhOOOcnvsE/48DReCWjxA=;
        b=clO7jr6Y8XRKbBccyvRWtKZQ/Dk6bXp0oD8DudRxNkifexMSktDBHij/Abvw7YdKM9
         63W8CfqHVkCvpmVmXXZ8Vm2X76uCXmtG5fBF4ZoF1MmDeHmFri3e7vUpAVb77qxXUf4g
         cGLInUNqH6RE6B9lxhaOw6omcSceLjlDsZcSHsv9z+9OvtVDS3vE/giWKSXhVdDE4Laa
         KvEoY4yNSMTrFwS7aDN8t6UPcAbc1Pym1+BZsrVrlX56xHXyKs6DRkTAQVId4hfHu/A+
         Kwn3ro0XXsLcRul+U3zOUt1Wi85J1lz6UFIuij924XqpvlSBqUPpAkPgJA2waxo42+d0
         poYw==
X-Forwarded-Encrypted: i=1; AJvYcCUiRMMmqNfIhL5cE0T9C53tGcOvK4JLD0bKgdE4K55Lx/toPNd3zXcQBFn11jKqffGvC6yHI2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQ+p3hKWCGGEfAi8fzTDUS6fpWe2Y5n6xuGFQQYLm2PYQfozL
	WOsozIKictL9N4HL5C/A/5suBmgzDWBH2XRzD7KQzJX2noF+QJcGWcmPzinyB3aZ
X-Gm-Gg: AeBDies1s0ZBxqJ53mopfTb8fQNfHefvQwH/zwD0ZOmTSOOfpsuOrCOxCEAzFM+xgi8
	YBTAheSw6B+gIz2UuKhHr646loX3mU5Qd8GA+A/JD9g3LVRQOS66ZQtPRmqy95GUsrzPqpqw/Kx
	ddC0aYtqW7YRLPu43LUXx/7ipYDQLgsnEsJN1EHyzertjtdQ3+bpEkLewW9zDvOuGrGZa/nSInW
	x+XAqpyIRKZuvefyew5a9BQbQVKAVYFXhFznRSyxnOmhhxAo9/fEB9omV6V7ag65IlLSP4hAUiy
	z+moFZ9hwoHySlpM+BtYZ5+oVyqUHB6Bnl2X6jJhEnp+kkZxQLLWIW2bTBcbIu6kg4V3mQqC0tY
	6hGL8ZHLW/2lQEighzClwgyECG8r7yh/8tzssGNscPEhcXO5+ICDifv94ZeYTQkoFgWfMz5w+29
	35KA2st0sk94vO637QcBYNHRx+rXk7EZE6704OV4N8R3+aPi9tqeJnTxI+630dS5hZUX7tkoC4H
	Ec=
X-Received: by 2002:a05:600c:3549:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-488997d5e84mr260217805e9.26.1775637742788;
        Wed, 08 Apr 2026 01:42:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5d854ebsm13286165e9.19.2026.04.08.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:42:20 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:42:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "linux@weissschuh.net"
 <linux@weissschuh.net>, "cosmo.chou@quantatw.com"
 <cosmo.chou@quantatw.com>, "mail@carsten-spiess.de"
 <mail@carsten-spiess.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Sanman Pradhan <psanman@juniper.net>
Subject: Re: [PATCH v2 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Message-ID: <20260408094219.3aaa4ad2@pumpkin>
In-Reply-To: <20260407212122.278824-1-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
	<20260407173624.247803-3-sanman.pradhan@hpe.com>
	<20260407202146.59b1476f@pumpkin>
	<20260407212122.278824-1-sanman.pradhan@hpe.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233817-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F4DC3B93BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 21:21:31 +0000
"Pradhan, Sanman" <sanman.pradhan@hpe.com> wrote:

> From: Sanman Pradhan <psanman@juniper.net>
> 
> Thanks for the review.
> 
> Yes, I checked this.
> 
> In this driver, gain is limited to {1, 2, 4, 8} by
> isl28022_read_properties(), and regval is a 16-bit register value
> (max 65535). The worst-case numerator is:
> 
>   51200000 * 8 * 65535 = 26843136000000
> 
> which is well below U64_MAX, so the multiply cannot overflow.
> 
> I'll switch to min_t(u64, ...) here to make the type handling explicit
> for the u64 result of div_u64(), if that's ok, and send a v3.

No, use min() not min_t().

min_t() doesn't make the type handling 'explicit', it just casts both
values to the specified type and lets you live with any consequences.
min() attempts to stop you doing 'really silly thing' (mostly trying
to stop negative signed values becoming very large signed values).

Even if the compiler generates a signedness warning from min()
replacing it with min_t() really ought to be a last resort.
Not the least of the problems is that people have a habit of using
the type they want for the result, so you'll find:
	x = clamp_t(u8, y, 0, 255);
That is just:
	x = clamp((u8)y, (u8)0, (u8)255);
which just masks the high bits instead of the intended saturation.

	David

> 
> Thank you.
> 
> Regards,
> Sanman Pradhan


