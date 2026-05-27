Return-Path: <stable+bounces-254554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPGmGKvUFmq+swcAu9opvQ
	(envelope-from <stable+bounces-254554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:25:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6445E5E3571
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22370300EC72
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D53EF673;
	Wed, 27 May 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO9/WxYC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6A3DFC7C
	for <stable@vger.kernel.org>; Wed, 27 May 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881090; cv=pass; b=G9zApvI71a8z1vY7ycVFGOcAgb/h8rOecRuUzC/PYdd46VpDFU4BoBa5/4e5ej0yqM60VRWpbLsAlHj96Ix5YKwwtLAIkTWB185N6G2LAAuqnQsoApgVjuWU38B8K7/QokXG8YmQNUDCU0WOToGkQjveh9bxTarHmVu1q1+SEvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881090; c=relaxed/simple;
	bh=6f36UCay5OAn9ZY1CaIQpcW2YbapEdBtYAL/RUTsKHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLELE2sn7W5c3+l10RgGq0JMrUHgsZXxm+CiMveqoOSwWpFzAXy48StGjExZPQLYQHDd2h1PUHIsC/xg93BctpwXVmC1xBfO+0HtQqgTisHVpyJXoCsrNjKrT8stf/2W+2r+XjwJNOOT5ogottUo1YFfqj8rHq+7vwli2FMjZkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eO9/WxYC; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ed18d8a1bso1472188f8f.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 04:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779881087; cv=none;
        d=google.com; s=arc-20240605;
        b=XnHrS6KvG8AOPdk2TrU8IYAbb4WUVvQKkrnlouj624pXMjcbh0hF2RDHcE7ObpckUb
         To0TxH0sx5iVNrs7XO5EeVvEOiAvckzXrQKK6507VrfZLO+IwF3UNNWHijy9Bty/HbxY
         J/cQ3lNpO3XiMtr5XVcQHSgpvnrKo64Epfidfa2aqJQWDgKs/gzfx7rd/CMqJFzBD9aQ
         rBoVAstWpDo/1iGeCRaWNYb+V9zk0EejX2Z02rW541Wpel9H8yBKa+/HGXrB4xD7dKti
         +IelzkJVbwX4myXztFFfYfxuN8mkg+oEnL3/39jO6ZLc52rp5kdInS/P/7Uh3EA2K76m
         VNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1oSdfPlt8ivfVcrtc+mkmI3RhSITwTlRakTSHCj1tzs=;
        fh=tOeM9tCzqrrA8ap3fI/l6CuQ6NVzugPuqU2kCdeQKHc=;
        b=XPfoi8cL7ysTYxRWIoKTzohsCb7uFyEUtnlmgpJLX8hmElXqgLFkHbw2B3BNri7gR+
         I8mm1jFOxz+1GRblJJqXohD4hJrtkkZ/tXK0igCXyeIlTC6T8GQfNVUb5VCFOQrqfbll
         sIEzx/ms4QYlHRssExq7ncxsy559pt0M8fOaoRS+Hu0hJQOEOFrZIMNJzovhx+UtFW7U
         behbG6F2AcntddLhBMqezYP4dPhNz9uH+GyiqdAPo+zIjronTFYznU6LIUxjSIf1FMSh
         /95M9//VskvsY9a6dSyY77rdc5Yj3FitPh/a0QHMhNE8eFxvezs8k05kDcWsd4RdzMgp
         8TSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779881087; x=1780485887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1oSdfPlt8ivfVcrtc+mkmI3RhSITwTlRakTSHCj1tzs=;
        b=eO9/WxYC7s1YBnw51qdqxW9xNhCmHB0qgFhXawJQ5kuoMyF65opaBbA+G//lYwfz5Q
         2PBuR2c2vG92+eouJ6HVdBagg4ISud5OnKSvmM3YnbqJVPZtgeo0kYgRImXtIYsB0lro
         Q8Rv299oxUPwY8mSkUmmJm4QOuANtMpOzp2SyMQzbeaRahoutvTZWzk04Y7tqa18QsYc
         OvcIqtMGLeO7/5z1zz0Kvchd1vVmT/4d6P8DZ6AnWzZaSuX7ejBfISEMaa4880TkaOOT
         H1DGnIhX0xSOqgOQ8zaVYW51ToF46bg6G23pBhXppGMrVD/tvbgqyM72BvNZIOo5hO4Q
         SWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779881087; x=1780485887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oSdfPlt8ivfVcrtc+mkmI3RhSITwTlRakTSHCj1tzs=;
        b=GDeKRCotiy3P1E1acdPJDA6d3I/DnNHzOohlUNb/KXQufYZi4BR5d7xOOK7qhVUbga
         gZGGC80JsJLVnf1UrYlWePijPIyUxyA8K8dUeYdISGLdx6uiDisOAIQNWVxcSTm1+F1v
         bcwcK3Wm56NcPL7oUEFMiqZidRrz3ofJtXUP0u+8rpRFJQSgu2/8gdgjSgJ/EYTNaG2x
         M4aTBMOvnJZ1BGpo2wKse2k69Z5H7CHUYlCvwyMhimmAOD786HUQtImM112+eLN6hOC1
         jgzLsr311XmOBDn/t+7YJvqSf2zCZDfd0USwadKxa+s8+H/uANfEhsf+1mNDJCmGuqjP
         9n6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ZUolNpqdq3h+y09mwmKDcrJ05dgJIxFnJ0UHOiktVUl2p5LCnQZZ6EA/Ul0gvefRQeuUpgdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTX9zw9R1pvc1Sdt6U/w3mJ3KSqbAIrsa3AO+ry6XCuCmktxWl
	IWvQ3gU+r6D3VllUJub8Npl1iurN+4zLpSrPQEbwUP079Vjy+HnoM+RnLkMRocIR1/mEj4y00QH
	pPbn3HKI8+1LAVcRDtwi6/62RZyjEGrQ=
X-Gm-Gg: Acq92OE/80Sq9iSEmpWO1VfzPAFI4uSuiyjgIXKsIm8oPeNX0c3GNeysX0RCZoCgGn/
	p+ig4ZsQwS84gqy5HvmGel1lKgCQRwH9VXdnMTnfQZZEwN0d7/1Km8A8TyFhLUrpkkJBNhK2mDU
	398wuJEbDa7+ZcQPDSQNcfQvjQ8ZOxW11ubN9uHnWrjxsv72sqq6p2Ykiwqa+a08HjbcdcjfjRe
	TUj8qiVzTLwwSqJI2b7oy+Q2YSOUx/VKWnr+q6xvTdiyaNc4mXT/5m8hvL7eW091lB0jACQCUFk
	r1C8hKHTGeqgFAVisQChV9y3ahGt5c/K7kwmy02cVaHtc6X6bYjUxrZtAB0HzewfnqYs2zV/1iP
	7doAA89QLIrOswUJLVsnwOa2+d8r9m2io7JYDU/Qfwm6h120T5N0EPd7o1QNyYtKW+in+ftwQrq
	dFuMGl1TfTWZqx16VR
X-Received: by 2002:a05:6000:468c:b0:45e:df46:ba30 with SMTP id
 ffacd0b85a97d-45edf46bd4emr466838f8f.34.1779881086531; Wed, 27 May 2026
 04:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-fix-early-return-v1-1-c70e886329f3@gmail.com> <20260527121159.4a4f94bc@jic23-huawei>
In-Reply-To: <20260527121159.4a4f94bc@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 27 May 2026 13:24:34 +0200
X-Gm-Features: AVHnY4ICcG_SbVWlGG7pp_NTcZD7e61UVwmjUR0z7ffrciGosxMVadE5mVs8LQE
Message-ID: <CALoEA-zuzkR_9aGzM+NGWVWcN0ngf-1tRbBm1exkASkx+m9eYA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: opt3001: fix missing state reset on timeout
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jiri Valek - 2N <valek@2n.cz>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254554-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,joshua.crofts1.gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6445E5E3571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 at 13:12, Jonathan Cameron <jic23@kernel.org> wrote:
> The flow in this function is horrendous.  IF you have time would you mind
> doing a follow up patch that just breaks it in two. Then have
> if (opt->use_irq)
>         opt3001_get_processed_irq();
> else
>         opt3001_get_processed_noirq();
>
> Maybe there is some code at the end that is worth sharing - you'll have to have
> a play to see if that is worth doing.
>
> (If this was in your other patch set already then I'll blame lack of coffee!)

No, didn't touch on this in the original set unfortunately, but I keep
discovering
all sorts of strange things in this driver. IMO this warranted a quick
solo patch
as it can potentially mess up subsequent reads. I'll probably end up adding
the breakdown in the other series though.

-- 
Kind regards

CJD

