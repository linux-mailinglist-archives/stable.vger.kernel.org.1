Return-Path: <stable+bounces-152396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE01AD4A67
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342E917B8A2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25596227586;
	Wed, 11 Jun 2025 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WHUwX5FT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495622689C
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619439; cv=none; b=Gj1CP313iSM88gpG5opRQFFDAiqn108FWfzSCYP6OgGvEbOGSbezzzA5Qy9jgzrfqaLzeDL/Hxs47Y+5IRsM+K+rZTBw0oZe3GjKOwt5em+h3IIBCf6wSdOakUp1TjPkht3s4/dUepOAma4hvx5LBr0aOPxwRfgbCh3ZsYreskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619439; c=relaxed/simple;
	bh=ZRvJ4sTArvkMQ3RZLBCPBHuH82M/Wau366iNsz5Hsn4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=NeJp/VjSDHb8VUzKvUOhXbPHFvQ5H8S2ZAgnKU0CzN3bhX6XLh4N/ytTePDqgA+W5p88eceG2GfYMQcwzAMKgCEEjCNtZPwMHOsnd2ep4RSVHqKRrsSTwoapDlAv7lsv7OHkuI7Yz22uO08oiShqouOz2lz3HVq0Gtp31GP3ScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WHUwX5FT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so2605511f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749619436; x=1750224236; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZOq6Bm91egLyNY4GfKgWUHZN2VR0kd26K9RfUAujw0=;
        b=WHUwX5FTnDiuplje+Q9J/Rmw9BwP/g0lZ9fXjKsWrXJ8U/6Bb29Y7WAO0F55g7CPg9
         3gU0JkPvUp2SNdSD8Li5dm2pM1I3RC+4al7wAweC7r86oTlaOqvabT41LRKHtz5Lur5n
         ccyzhu6K5ds4VIwAbLyk0FWg9VEni1zVsOxmIr0v35e8MTkMh4yRtQ6svHMPLD3fArTm
         cGY/Z3mJCbI5J0eQO4y93XPRMqIXu67OwGWpAxcHUr0MhuxrA/F0cuCaa/UfF4myQzUG
         gzYEI64gSrG/ECKidqU4QeViGyHcsedXI+hJcfcMP2F6Cjb7OR6vPen/+CbmfLah1nc6
         n/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749619436; x=1750224236;
        h=content-transfer-encoding:to:subject:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ZOq6Bm91egLyNY4GfKgWUHZN2VR0kd26K9RfUAujw0=;
        b=t8QsFJYYLzy+tiOFXpRXaiiSJ2br5/rpkh6Cwo/rj0kmeeE6v2vpxPnc7M7ikOfXaX
         1e/plH91An07AJdhWgAXPTkzxoVLunKKROk6GPoAfvd5Prb0e/O4vgCLoCwXAhlCw9/G
         h+GXt+KE3LfmQ0TwlIUr7F6jOoGxvKLzYN4lrxmpFhSKbEPiHASf9rGS3OJIQSeZ6TBp
         0RSMAH+h5LOafsP23ZDljIYWXoezyIFoJEPKYDbGCKZhPW9m5w2hAGuW+xajdYn1adtf
         tlYXKs/9z9nQtOlwWS8ojZFWPa2y/nLgaCGBzJUDRug6NeJcN3uuJjkpkuRCQrlK0FSw
         Ns9g==
X-Gm-Message-State: AOJu0Yxh9MoGZStXLUbMdOQiEOq5AXqvEmIEf77jZNB2cZbBxQkl68d6
	iZn+P2J4DQ7DAUVGPlXCDMgqlN4dF8oDAMgOEw3IPiNjeyVKH0rJSEtc4ou0WVuLtfeBc3s5VA2
	fhpHL
X-Gm-Gg: ASbGncveAEpIEpe20m89U6N1wCXheLDK3rxq21wikImJ0rnpNayvmdP9wfNFIuPGKTd
	BDIkiVgwfH1LDypYCIHzqyxOEw/qQ1bK1Jnbad9zU1wmgpIupQS7SmB9vouktEa7iJpN9i3kx5j
	Rj7q15xsB1rGbFDj0A2e+8cI+M3PHGX0cZO43ADCOZfiSzRs0TmF1H50nreRBvXSynFHaRGOpGe
	9Efe6DkJSWmm+UotpjiJyBBnBl8lrX/wF96OgNYl7m1uU3a79zr0TDYrHlpDjDbVSaGklpGj6Uo
	zYKJhbAPS+lmOb4X6pCMEroNjdsgpjGpmPdYtgbVKiqNBAP1sq8Ww4ToA/awtZuTH7lhiAI=
X-Google-Smtp-Source: AGHT+IFaPHndSHVrwkehC/VTOfv39ieh28zF9QlF8aTE1BIPnk9d1Ytd+SxjdWeg062XxjhgvZ7LIg==
X-Received: by 2002:a05:6000:18ab:b0:3a3:6b07:20a1 with SMTP id ffacd0b85a97d-3a558afdfc8mr1081969f8f.40.1749619435649;
        Tue, 10 Jun 2025 22:23:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b33c3sm14268695f8f.34.2025.06.10.22.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 22:23:55 -0700 (PDT)
Message-ID: <6aa4a135-eb89-49e0-b450-7fa30d7684ee@tuxon.dev>
Date: Wed, 11 Jun 2025 08:23:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
Subject: Backport sh-sci fixes to 6.12.y
To: linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, stable team,

Please backport the following commits to 6.12.y:

1/ 239f11209e5f ("serial: sh-sci: Move runtime PM enable to
   sci_probe_single()")
2/ 5f1017069933 ("serial: sh-sci: Clean sci_ports[0] after at earlycon
   exit")
3/ 651dee03696e ("serial: sh-sci: Increment the runtime usage counter for
   the earlycon device")

These applies cleanly on top of 6.12.y (if applied in the order provided
above) and fix the debug console on Renesas devices.

Thank you,
Claudiu Beznea

