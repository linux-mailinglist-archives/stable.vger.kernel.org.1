Return-Path: <stable+bounces-78175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51D988F5F
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946ABB2191D
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163CC187343;
	Sat, 28 Sep 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNCMgsoe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541071DFF8;
	Sat, 28 Sep 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529594; cv=none; b=LPuNCIhC1pzqtE4tJJT4ENZPaAmPovcUd9hPfEBmoMjlYy/3P/doXlaDTysex9MAbASa5r6QOfDJkuClaz20mKXA1j7wvlTNcEY+lG6ZsqyQzfOTFL4vxsGnLXEhhMeikaxsccfexSsq/aSOcBKDTj6V/6OBjNEiPvvDeKQR+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529594; c=relaxed/simple;
	bh=FTxgGV0fndARRaInbJBSomb7m073sgDRktv/COxeuhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Elb4KnBom+KV72wsG1Nog9C/AxWn81Pg+pMu4PiahVCFFimrR5natvuG2+yYwfRT9rGsGHd+FDGw+2VP3WH2PeVvIJrQ3efyRs1vbZ5K6MnnDd3XjP0FvHcHaLaSlKpuRe0PI+irdEYGqrusUPYVVgsjebZpK5ibN/7+pP2jlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNCMgsoe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so178927a12.1;
        Sat, 28 Sep 2024 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727529592; x=1728134392; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QEHG4Y/lL09GG1v2gI8iZvDJa9no7rllEAszsGzy6GU=;
        b=SNCMgsoeF3Ml/SxlfJHoBW7/e4Yp1jh7zUZ22RP208U37DBiJgg0jcvp+sXujNTRpm
         MyfyIthpU4Oo3BEWnz5gY5j8R/xqH1124Rn0tBaQ1eK6I8welA5TWlV0OcAqmOyrPlRJ
         PU0PGe2E4jpVGyRqjh82PcmBJ/EM6TZlijdn1BQO7EK+LBKMpnVrWp3618UG5oJQlFek
         IPP9eVqtqWk68ECD4nAHXZvn1RyDy0GyCDdmh03DgYsBTL2kB7P/It+ZzE3QGvb2/VXk
         +CClE3+LTrySz8lxe4PNVvZv8duLpOiLxxiZn9VywEM9ZtI4fcUaNScM3qs551oDHRSt
         eehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727529592; x=1728134392;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEHG4Y/lL09GG1v2gI8iZvDJa9no7rllEAszsGzy6GU=;
        b=oYouakoXs1jbIShaIF2XjNwFbpvxBjWAHUY+FgOpoJA6hvsNJg99h8yqGVg437RhXl
         DBOnLrKobidZJ4dESAM7WfZXygOHFq2rjN5vUQYeueRBxk7/omqKUEXfOcWMaTXaBRdH
         QtWVJdKlF6TWUB5m9pNfcXEamnJNNXNcxsT4ShUSt1mxQd3bWEe68LoHKVSxuEpzzWIK
         nGiCLLx0x4Kfp8e34/QODc1FnFA8qd+2WJzHdJhthjtoKxYoOGf1rhIuxrVHqfuPSvCD
         sbG3AFGfCBTNfkh3Bg5+cuTzipOM+WTLFBzLNx1aLn5hQyE+q669v+xUOzFSzqFDPHsw
         SXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg+d3nmqgvxaKf9zlaqgBDFo3y3cC89QX0t/+I/+rk0Z7m6s1LhVzDdTY6Zj/gZSe/DKU8GP0R@vger.kernel.org, AJvYcCXJz9+qn/iRsYxfYL3piupy3p3wa95czSM21d8PQg4ogYCYye5nPZWm7EFq7ffYlC5NV2ZoWZ1tqG41NmY=@vger.kernel.org, AJvYcCXUbcQAic7KnUAu6EZ7J6Icgb/iBoLOydd1J3KPjVrBkjDIDU8YN/fu1w6oxLmkZ+WJE9xQVAzVqyQ+xG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPd/bgCxjFYLAh/LtpI0IIdzxvxMu2ApK2kQfpZhkzeYKp1M2
	yH+QHr3swm5NjZM+hNu8VnbYRD3H4LmWRg4vn7Z8HQDvMQr+P6El
X-Google-Smtp-Source: AGHT+IHbW7D+GnxBZsSdqkqhplAXMnTaQ9xufE4rC3XiSWGLDgQLRazAH0M/yYKlYU6i2+CXttb1Kw==
X-Received: by 2002:a05:6402:254d:b0:5c8:8844:9942 with SMTP id 4fb4d7f45d1cf-5c888449972mr3305438a12.2.1727529591422;
        Sat, 28 Sep 2024 06:19:51 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248c672sm2281445a12.60.2024.09.28.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:19:50 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 36E93BE2EE7; Sat, 28 Sep 2024 15:19:49 +0200 (CEST)
Date: Sat, 28 Sep 2024 15:19:49 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org
Cc: Eric Degenetais <eric.4.debian@grabatoulnz.fr>,
	linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [regression] Regular "cracks" in HDMI sound during playback since
 backport to 6.1.y for 92afcc310038 ("ALSA: hda: Conditionally use snooping
 for AMD HDMI")
Message-ID: <ZvgCdYfKgwHpJXGE@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

In downstream Debian we got a report from  Eric Degenetais, in
https://bugs.debian.org/1081833 that after the update to the 6.1.106
based version, there were regular cracks in HDMI sound during
playback.

Eric was able to bisec the issue down to
92afcc310038ebe5d66c689bb0bf418f5451201c in the v6.1.y series which
got applied in 6.1.104.

Cf. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081833#47

#regzbot introduced: 92afcc310038ebe5d66c689bb0bf418f5451201c
#regzbot link: https://bugs.debian.org/1081833

It should be noted that Eric as well tried more recent stable series
as well, in particular did test as well 6.10.6 based version back on
20th september, and the issue was reproducible there as well.

Is there anything else we can try to provide?

Regards,
Salvatore

