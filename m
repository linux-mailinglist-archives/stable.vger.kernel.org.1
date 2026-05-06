Return-Path: <stable+bounces-244328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN27Bdfn+mlIUAMAu9opvQ
	(envelope-from <stable+bounces-244328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:03:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5144D6EFB
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DA8430631A3
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830436B071;
	Wed,  6 May 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUDt4Gdy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01436C592
	for <stable@vger.kernel.org>; Wed,  6 May 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050999; cv=pass; b=d2OX7F722R3jcbmbzAp1HwWUPBxlsTh8fOcykXvukA1xhfxetIjmzaH/PebHRYwHKtCwUjfAsgQnqPIeOfThVvIOUU7PFB1m2W/JN5TSsKxuPAu2F9omgfffW1ge6S3DDkZi8Szw03gdgOb0GEFLdQVChwHyddJWXPdTA1F5wsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050999; c=relaxed/simple;
	bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceibtE5PsYGvv7ZJznlELeA3t/xdtZXLtrQuA6d5DQ3Ka9JzBkeJGoOUd+7Ei0a6EHo4I/+pzpBbx7JA3PtZjNaxHXJpvuMqPDzYY0m3yMXRq4T3NaT+FSxNv+yKdbx+WuGH8VcGj17ZT1c5evd/+xSNiTVWDv8DpCKhzOc/Mmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUDt4Gdy; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-444826c16ffso5760593f8f.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 00:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778050997; cv=none;
        d=google.com; s=arc-20240605;
        b=fdVNWorOq9mI7+9w8xWEhfK3MBp+mHCeDQq8aOAncRrmOe2kk1p06hWPrpOMAp7RBT
         VzzyQou5aVgzqoy5y9nkKEKkcZmyQ4L8W8it3gOHOjj2fg+RZS0bn/ihp3jB0Y1S6jGh
         UH9kCl84PjT27dKQJ9Pqk9hEvR1sChopFXdyjLujzE9rU4Mz2qMlrd4zhi1vbGztNByn
         38DCkl94yOlrJE2jdtzbN3E5lBHRkn3ccskuHdesaUg7ZloTW7cOXtL9ZJl50N/MqJ7y
         R+zhxCIP4f2yFyqa0+ZenK62XOvucqZ813C2b4XUUJY/jRiIEzutB/GZNZnTZS/vrIyh
         7Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
        fh=D1PKsXNsjvAkRlUNHV/4DV1vLT0DP75p07TP9vNHAwU=;
        b=O/iMBeT2FtQ1/mrSW1FyN9STu8DkkE74xATPjCwrkHne78uEOR1EXCMsAa2UC30oHD
         xJxfxL7NLufXFN4K7WfqMEHB/I8QZlTaN8nT6Ay51THV+N7fwnk9T+/RpVSFHQ76JMO8
         zAKdaYcHbzpTm+WI4jtZOM6caBkgEGynl/tE0ElKFd+uXf1dc1eAwNfEwQIQuKuzh4x/
         VI4A0Yqgb3tEYDBEGOEwB4wQ3EJCkNbUIQbq/sCIJeNaB6pzPTHQ5J5KEj/2Wh17yXy+
         ny+0v0yVKH7hueDkSFOCgQZGO9O3gJ7HqrT1N6HmZFoGPqSQ8adeo2wmu9CftDpSIKua
         nbBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050997; x=1778655797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
        b=GUDt4GdyLfOXR6KMg8cIsn9NhlmXb7oTG0V9cc7WmzGIfDgRmW8hAwjGYtBiJDDM2d
         krv4Kh+0Pt96y9UfJpNJL964eyLmTdpDn89L3+2YbWdH65NsCUdGXTvg0icCtEPYu53r
         uZrE3QW6GiH6lfvAowsNRJieHXcKbA0TvoG9UBifXNCzatFC/tICCtIy2+B0aiq3bst/
         i98fxfcLIbpYeRqvqw75sJf1wc6KUa6koS19RGyc4uyGpl8g/26PbJvxuFqUJD4NftOK
         D8GEOpGe0E6QEBt1eQKcUJsCA0whWi6MM12W7xWFxKDB5i93rOKrqaTFI6geyBIwPOaA
         /wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050997; x=1778655797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
        b=CNj5tUIid6HDpgd3N3j0Ew30eL/h1Q7d+pnh5ayi6HTTD1y38xbhXRu35UDRqbbYx2
         pQTm7BHdXNIaXhoAsajcnLSURYse1u2frkJxvzOpQ0709vL36Rn20drsdagtFyp+D+Po
         yuwog2Ameuj9DWAFlI9dHOx0xb/VLV21/5/C3jbiJhsoTRvtGVYFp9qdkQ6NRZIRrh57
         AdeHeSuO9wYCA760gtCdzv5eeE70mGwfr285lH61P7l85jLzYOcqNT2JiBf92v7rmrTv
         ovqXBqd/UiNW5UlLTCAWbiYVKl1AptCV2UKen7oNtDwXWr6iXXWtrG1PwfdI1/HOW7/o
         D1og==
X-Forwarded-Encrypted: i=1; AFNElJ9fW7jrA8SGOUSUaTnE0AhszDpTJORHpuWpOlSeG0S4HnmyjdUut1xAgK/s0caB7T5PYMP+c+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXJUmceK720TAyYjWLOce8+FgSQuhnYbVFi3A973xdT22p1TM
	YB0hBVYqOgKYfzq4K8ab94tCqtdpMSVk17sWe+V03TfHnJuAk7PyVnOqHCkho+g5fHBNzlLPiUc
	IuVMdlhNy8AemsiZdHLidwp+AzTg3N9g=
X-Gm-Gg: AeBDieuvFBkaGKjuQQrmdrSQfoKEfMBNf1YPuZdaKXUTmibmSvACaAfM2x33ZwJCvQV
	fUPLDupI0LAe7p5jGmFF+8oKdkCHjvLWGnbp1UtgP3DSQP931b1L4SYyEPfYdre2nm2dSaklsYD
	3m33jJrJ3EnWucX8BAojqGd1W/iSj4mqrqfDsx7SdtFtADFHVeUu6iNs/8beKrNjWKHwzYSTgC6
	54SgA53kID3QYD0vQHCI5pHj2fXaEa8SVT2XjQnPTBbm+wPQDPv5Rs6ZLwEbjL1zMhoQ+PcOQta
	FyxWRmF39F6vQwlKQg==
X-Received: by 2002:a05:6000:22c6:b0:44e:7284:5f21 with SMTP id
 ffacd0b85a97d-4515b9f4c7fmr3577789f8f.18.1778050996944; Wed, 06 May 2026
 00:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
 <20260505072015.1672730-2-maoyi.xie@ntu.edu.sg> <willemdebruijn.kernel.2b6abb6aae1d8@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2b6abb6aae1d8@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 6 May 2026 15:03:05 +0800
X-Gm-Features: AVHnY4IHYi6g460Zc-J1tqBob_f27_Zqaq9yQz8MiephHqEYYoxSoyau9SBzTWU
Message-ID: <CAHPEe=HRsdOeWEUTmJ48nqjrwfOzgo5ruAcNyR=LHR5MNRCF2Q@mail.gmail.com>
Subject: Re: [PATCH net v7 1/2] ipv6: flowlabel: take ip6_fl_lock across
 mem_check and fl_intern
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BE5144D6EFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244328-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[ntu.edu.sg:query timed out,maoyixie.com:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[ntu.edu.sg:query timed out,maoyixie.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SEM_FAIL(0.00)[172.105.105.114:query timed out];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,maoyixie.com:url,mail.gmail.com:mid,ntu.edu.sg:email]

Hi Willem,

Thanks for the review on both, and for the Reviewed-by tags.

>> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Please update either your git config name or Signed-off-by to
> make sure that the two are the same.

Sorry for the noise. We sent the series through Gmail because
our NTU SMTP does not accept git send-email, and Gmail rewrote
the From header of the resulting mail. v8 will set the email
header From to the Gmail address and inject an in-body From: line
with the NTU address, so the trailer matches the author.

>> +/* Caller must hold ip6_fl_lock. */
> nit: lockdep_assert_held as used below is preferable over
> comments

Will replace the comment with lockdep_assert_held(&ip6_fl_lock)
at the top of fl_intern() in v8.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Will add the same Fixes trailer to 1/2 in v8.

We will respin as v8 after the 24h netdev window.

Maoyi
Nanyang Technological University
https://maoyixie.com/

