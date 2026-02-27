Return-Path: <stable+bounces-219884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPweOezgoGk4nwQAu9opvQ
	(envelope-from <stable+bounces-219884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:10:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6181B125F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656503058BAA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DD1DE8AD;
	Fri, 27 Feb 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQiDRsy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281219F121
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151007; cv=pass; b=JnS4ThQeIkjlcg3jCiJN98utaoGX60+0Gw+/304w92iyTljnRv+C/9mXS/+y6OW6pnLupVN+ahp8CAHM1F2Rft5V76bmzYx6FRENe5cBs/Mg64TahJJl3rUAVACTwOhHESX5G9L8I0Xgkz5kOHn2zEwgyPfb7YKyVJ154aSQM70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151007; c=relaxed/simple;
	bh=w3yliF/QA8ccjkjhH6ZX+syLBtlmTPzIPPe6uKPvaks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l2vRHkiCgxOMBNsdilNZdR4MbWQJkSQv3/7h2Ydm/r/e8M9VicTCaqmHNevANEmeGytxIWOzD4atmI7K27k6QtxkzXowgs+rm+cY8CA6R6naSJqrNQDBbm5EmjuZyCkHtatrLvjRf5RpH//Z4aheZF+uVekQY4LGw+0PlH1bkAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQiDRsy4; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bddc698f46so49781eec.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 16:10:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772151005; cv=none;
        d=google.com; s=arc-20240605;
        b=SP7U4RLABIH3ygv7sQmeyGHC72CcdqWikYEWIZgMI4/JjuK0HB1m18nPs35EK+WzAd
         fWobhyTDh4jXIYDFMxHRl6EIcIew2vd0fnmBCjSuRpNh+eIGe+XjdCO/74IpWE4Qg09x
         oTbIjX13Q9EoPGdhmpQVsRL7OUg2zl4iZXqPMyp4iiu+qZCCqy0XmFH+AcvxPejEztW+
         UWrruVzP1sQe1oeXewQlayG+1JykcyCWfDGUV5XibsjK+fhED82baVN1n7A67v/Bw8gE
         STYvPIVcIVC2tEdRelWMmgT83m02aG7792k6wCDtc0yrnU75qayTex0c5XEg3GrT2/QS
         U+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2Hwhwd/Z0XLc9CVZPQfGvg03XaGo+eT08k90le7xP/c=;
        fh=JDGG7ZayOHq+Rk5JjpwWhgLnkLiyHUGE2YsoPjDwqB0=;
        b=JPGboIB2sqvxoQd1ZyEpvjSkx6hGzMHz9LhU6HeNWoyzH2DvNeYYw09QyaY2dGaeNb
         QYrg17F3ZZRajX9/ga2QGlQGu0WJ3FgGVFomyrEYcquHlPuVBeNyeLTLu1LahwINP/bg
         H3NYzdD1+oOs3WLKoImo4E14ll9JTOGVmXn2NzZlMnkq0M1f2oehfrHNiEiMtocEku4H
         WrNA2sufyc8ir0t+FRodStdo8tcWoBAAuzAaqTe5i3eKtGR37/shCUZx3DkZNE9G/ii8
         bY+SXukmcYgponWZmYU/mh8f4Fr9tkwiBUUoD5lj2r9dbN78qnU2x2QiFUPPqNtjlsGq
         /iRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772151005; x=1772755805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Hwhwd/Z0XLc9CVZPQfGvg03XaGo+eT08k90le7xP/c=;
        b=iQiDRsy4duWolXAMuWrhfiTnlmPywajCZJ98qcfkRKA7JAP5KkEej86IorP+K/0R+c
         9AwAe5W8SXc6MGE8BX/jdaTYgVGxJTqDOF6OpAJTpd7RARX2lnvzlLE/QJDclnj3mZ/E
         Q3z6ghq6YIR7XNIHYmrVuU2KO7IvNVOANxiW9ldUE+zOXC0L3hGllm11hM7YYNisTu5v
         9pnZlJHB3z2cnAoTlqUkabdavFnRaxd5OCKABSaETcHQteg2BiisoqMRb8nhqyx1rWJG
         lYzZtFMziYoQ5FMpdxuTpWfc3bYSu6HAewNp9QwwxCd7kbxCajaLWbjnsuVCqb12VpQ9
         n1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772151005; x=1772755805;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hwhwd/Z0XLc9CVZPQfGvg03XaGo+eT08k90le7xP/c=;
        b=JlVZ8KfHcKdHz9SrAFzC/eAE6gBkN8Q7/JTM04qycmqJ7SoTKAGHC0OaTxM2V1f6Jv
         W1ygcSuMWoxu1m+sD2B1304DEHqgUYQ7c99GgpSn8gUc3nSYe5AEwB5I86hmdETVigPD
         YYc/xhloht6HdNzE4n8/cAamS4sV8wq32RgFV1G29qIZxXvg4zrkngRkA7BR4UTo1uSQ
         GkOlLQjRocOu2kae9px08/otS8gFi9reLkg+KofbhkmEOilMQK3rhjRyUux0B/L4AjBQ
         9QdFMhEd7bULo3GmJIylpotD8Py2w3MXW9E1z8fCsG4MvkyljnsQShEs+B9bzy4rPRZQ
         LoWA==
X-Gm-Message-State: AOJu0Ywa/nY6y6CmaUiY0ZIUR+qdWD9f/vTG2FJ7J7RuWJt8kkMSJM+S
	2uUg/tRcykryB0A7qiZBoS2WEQyXmGmFt0GxpvHKnZMXy4xGh9jcPxofhpxX6Et5ZPsk/G/9tQW
	0cK/L2g8JoKYv+qfZF7P2PsGHFDNh2GY=
X-Gm-Gg: ATEYQzwew3N0K5tr+buf6loz/n01M9rKJ0IpaGvH23XkTcROx0O0lm4futZBBaZPnEv
	K/BXRKyUad9DdbYTn7KOk1iXMJKORn3qWE20pT7c0iLQZOVy31GJVvSI+Pzmswn4hH0ZigPt9xA
	px6KpWipKiSkQNw1g8Lqr/YQ/ZguM7Gbpenu6nA8M0S9zhinLTnKQJQ7NQeBlyKsd4pzzKkLkoq
	Hueu0j4Ued3T29U5XoUZCzyXOrTn5xfvG2+ypAg7bPvDQ8WVS/k3GbGzZXa8if2kdDToZ4VURWZ
	TovHXkw5vrjFz0Jp9qggSjsdoQ5zUbNZBxkN1eafnkL7xknq+TDsuXPfDFCzS38qPL+KSUetwVF
	g4LQ9bEraDGLEZD+SdrIYwYOzZ8Sn
X-Received: by 2002:a05:7300:dc90:b0:2bd:d8e6:90a9 with SMTP id
 5a478bee46e88-2bde1cf8740mr233452eec.3.1772151005326; Thu, 26 Feb 2026
 16:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Feb 2026 01:09:53 +0100
X-Gm-Features: AaiRm5366TIUWVYub0MpI4RTYz16tXLpXOUhkb4SAaHXdQUWYYOMTev0gAQU1Vw
Message-ID: <CANiq72==sRsiU6oud-THBVcqJMezQYAEDisHS2-30oyrMo4maQ@mail.gmail.com>
Subject: Consider backporting 174e2a339bf7 for 6.19.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219884-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4D6181B125F
X-Rspamd-Action: no action

Hi Greg, Sasha,

Please consider backporting for 6.19.y:

  174e2a339bf7 ("rust_binder: Fix build failure if !CONFIG_COMPAT")

It cherry-picks cleanly.

I hope that helps & thanks!

Cheers,
Miguel

