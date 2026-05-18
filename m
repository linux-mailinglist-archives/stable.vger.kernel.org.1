Return-Path: <stable+bounces-249236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ObxHyfZCmoA8wQAu9opvQ
	(envelope-from <stable+bounces-249236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:17:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA5569846
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 128AB30667D0
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C4F3E3DAA;
	Mon, 18 May 2026 09:11:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE93E3C40
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095464; cv=none; b=hvxm5JlFNwyuyA5WLle8QsnlGNDutrWrwenzG24ElgLZg6yvGoNt0T7/zC/kbIAVJfA6F4pkgHDsYE41IRfW/yd2oxOUh7V2fjsILTIi21agrZcEit3afol04MgLMIqz8PukF9t2sj1Lysv0qw5F3n8ZFTFUVYYJn+COoHUIJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095464; c=relaxed/simple;
	bh=/vPQIEV4/SgDSzC8EDs9ehJeVmZQPBn5YAqt9QP3nEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t45R5sPM7WYxqyx73+SksGFwcRNQeTQAxNuyidYyLeZnibmeIBCzPLq6X0IccFxeZYH1LsuX94ZZqclPCMm8RRF9sEhr7RuwMbZpN38wsdx9y6fV0x6QjeE40edXOSrAjwRv54gLgSFYHx6qhE9+QjtXCT+2jToHcibqLTYtq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-575171b1ce7so467423e0c.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095462; x=1779700262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRYZ3sLzBtPinz1jCgMS2nJKx1VYP4BGEJ88Tc5uCp8=;
        b=VjFDSSNeYh6vXJCs+quvC5kFNkW2RuC4AdMQ489FtT4miQ5sB1yLMwcrqNfsJeO2so
         W68P/SUoDAq+GfiY/gnSpFS+gpAxXwHtgBr8pYz2q0QKaj7CB9HTxbGEGBEwH5+kEhvG
         G4QeeU+/OBsoT/iA6OTk48C9L8C1kMh3W2ZZRpM85kFjsPVTE4DI8VFHydonjxSsXKrk
         Z3wmOk2dWNvcId9ONDB0zkdR+25du4Nj6u2ENidVOR+Il3GOse+FaqtViiMQyA58U+vv
         YHUpRdy/gn7Qk8kturmznCJUmcIlJqtwsrP+RJgTSzcrcl9AfHf/8p4gGax7PNh0miNW
         JDYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LEARh4MRuTJVSChLxJ/elodIMKkHISwjjIjB5pOfVf4nDE9L+/7uUUFF2Zglko+mekjKIj/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAPpeeaU0uAWlWpkEr83zqj3wZxMbkM03c0Pw675ifQQbGJMO
	pJ2TYhvVMBgqkTPNBV12uEbaHfWT/WrwxHVOEWbLRP7xI8PwdYroRzhaCVdUeX/+
X-Gm-Gg: Acq92OEZsfvJ8SpU/8AI91cilyq0amXMv6Bs/q1kN6kmVOy5xP/yOHNZWPpm7Zo4jL/
	OnUS9ZYgvQyQOSMFRrIZKBaGRJfkbnKs37qMacOSXCOozIANBoCZpv091vDM6vi56vfWX0DpMkb
	Qn2+11YD4wTw6oVRspK37aWyxJs+Ncop47hFLCzLRXHWIWjh3rs0Pi+FLh5whL08knqsJnoEbOQ
	2ZEchTRJmfyO8GIye3rau1LtCUQdAwyCZhXqiOwjnW34RPXu8rHS+17tDcXFSzxMGVLXOi1mcih
	seaBbiPlG0pWE1Cny03gwwdhsSyN2k3rRFsKMl77jyYcmHRkq+QLGa391R7q2grwfLde8iFu5Cv
	+UiYSBfjd2IYBgO5ZmBvpHGa7rBIF1D6gID9FWSCvLdUMgDQnULMaeXzW80CJCt+j6q2yPLIUoM
	T2TL2wrAtYZxLmItwQJwXykk2IxMFzAMWYggAUHWNPKhyHB8pgBIBNzZEchzWpf+ICsI6RCaw=
X-Received: by 2002:a05:6122:4f89:b0:575:e902:bf83 with SMTP id 71dfb90a1353d-5760bc3b8f8mr6946179e0c.0.1779095461830;
        Mon, 18 May 2026 02:11:01 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f5db452sm6073138e0c.6.2026.05.18.02.11.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:11:00 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-632a055fa9fso631381137.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ95E8vIE042tyTeX8TlbcBdVVo+0HEwIbKheQjWfZfadbuhmQvxa1XV1xdhXtYAfAt9i/Q2zy0=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad4:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-63a3f8989e3mr5604834137.24.1779095460227; Mon, 18 May 2026
 02:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org>
In-Reply-To: <20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 11:10:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzWL0WZe6u-uY2U+uCNUKB1aNTYM3kaYkX=OJBCY9G0w@mail.gmail.com>
X-Gm-Features: AVHnY4Id0khCZ3ZQ3Xy8VTkUfy4-pbQWwRD5BgHydP7l9eIjiP4DncTGcfkDLiI
Message-ID: <CAMuHMdVzWL0WZe6u-uY2U+uCNUKB1aNTYM3kaYkX=OJBCY9G0w@mail.gmail.com>
Subject: Re: [PATCH] HID: core: Fix size_t specifier in hid_report_raw_event()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1BDA5569846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249236-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Action: no action

Hi Nathan,

On Sun, 17 May 2026 at 06:51, Nathan Chancellor <nathan@kernel.org> wrote:
> When building for 32-bit platforms, for which 'size_t' is
> 'unsigned int', there are warnings around using the incorrect format
> specifier to print bsize in hid_report_raw_event():
>
>   drivers/hid/hid-core.c:2054:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
>         |                                                                                         ~~~
>         |                                                                                         %zu
>    2054 |                                      report->id, csize, bsize);
>         |                                                         ^~~~~
>   drivers/hid/hid-core.c:2076:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
>         |                                                                                          ~~~
>         |                                                                                          %zu
>    2076 |                                      report->id, rsize, bsize);
>         |                                                         ^~~~~
>
> Use the proper 'size_t' format specifier, '%zu', to clear up the
> warnings.
>
> Cc: stable@vger.kernel.org
> Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/20260516020430.110135-1-ojeda@kernel.org/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, this fixes the warnings on 32-bit for me.

> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>                 return 0;
>
>         if (unlikely(bsize < csize)) {
> -               hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
> +               hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
>                                      report->id, csize, bsize);

Both report->id and csize are unsigned, so should use %u.

>                 return -EINVAL;
>         }
> @@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>                 rsize = max_buffer_size;
>
>         if (bsize < rsize) {
> -               hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
> +               hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
>                                      report->id, rsize, bsize);

Same here.

>                 return -EINVAL;
>         }

And more incorrect %d outside the context!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

