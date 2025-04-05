Return-Path: <stable+bounces-128400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC4A7C9A0
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 16:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCC5170F32
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E111CAA95;
	Sat,  5 Apr 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J07iPH8x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1E2576;
	Sat,  5 Apr 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743863340; cv=none; b=kWJS8gXiZTmtlaQLKDV+cYqYIKR6vETO2zkZdxSca8naCCM6OwG02xLi3du5AQVp1MUH7PiBSgSLNMx29sNxtnk9/+N8D7hks5sN0RxTq+mDnv0QL0jrgtpAVTT420Rp9hcjkLh+0tDvKH3NB3wMLnCq5dpURK1fRWNZcqtErxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743863340; c=relaxed/simple;
	bh=4JfXyCl3pyf7S5ubtESdWHCjWxur7IoQ3C8ULhskaLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzTtjWhciqa1/Oh8LvUzKvdDRlFq5qOHhs/cpmoaQB61xHvRoEr8uSju7J9Z8Chex02cCBG+HmX5iIBjmSqjc1elBr47ZLOIIwmo9KYWw/TPKP9KCer1WQSUTOmKMIMzfsGtBRE1yMqo0/ZJlmBPz0rHMkg3cFoFZz8jofyqTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J07iPH8x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227b650504fso27385745ad.0;
        Sat, 05 Apr 2025 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743863338; x=1744468138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahwQ81oXocQBWNsh5IPSlPP/mK02nGlAnWcU1yfQR7E=;
        b=J07iPH8xNc2bdnOVw0OsnJLOUYYze0LcRoboyeS7QJxexRoTj4/P5uqcQ+OLkAwx8R
         ilwITvrUPRyXVUbLPYIOs4uhGYwgEdEPUYTnzpelNX46sUNuoaWJdXFUxFqvBBKMXWg5
         IWa2+0R61AB/ztEEeavpnDYHDdyV2/lkyzJaAqS5zdDme0N+VTorPTbqc/SZs2yDbVSV
         PPI82/5m/YyQWNNRTqMucbs1DYhRNIajKta8yssXZ05bQ7MmLskd5mqTrjsIBZI5ygGd
         /1tgtjUKBrcEyMy06YfO2hDGad/y8lff2jxBIZWbfulmk2Ad78QgEBn6Xkkb4kpZ8QZe
         zHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743863338; x=1744468138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahwQ81oXocQBWNsh5IPSlPP/mK02nGlAnWcU1yfQR7E=;
        b=oQnEEESsmAVlzCYp1AOA5TImz6QwMgUoOkP56LzY0xi4zQjQhX6K1ZVoLQfORA43Vv
         6F8VAEUrgal1hb0ZCXffbgqEcaxpIytxlafJsVr1D+drB+2fU6jRXu6TTUyFQ0O0Qmte
         hVoZ69xZ2p6Y+o7Il/o8gmAYpcZL2e0jtsWvFLzn6jWVlcMbPQwR/8NoZ+j0NcwRBvKQ
         WlCsG8D3X6XVDM07MDbVWinUFdBEjMbAngXUyRH67N5mo3Chg6lSl23ylptiQMbtRSqY
         DopRDSQxptJzj4lWH3NhAvt/FdL7HqHwG1MDb5jOs5P8fMZLngu8Pbv4R1iT9OrzlpwE
         AWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCULDnEjAfTlHIcAfzBXibfyzdTnYfk0QXt9wfswzkutGNsa2sX9HjKsRF96O6zdkFDhAVE8mztjOKWtOqKb@vger.kernel.org, AJvYcCUYep1Rn8E44IKDMfvXNzpGq6pm6jOE/vfiw4mbU9zuwB+oMszBCI7DSXj0eK9OALv5Xf4+UrEUg56+tRI=@vger.kernel.org, AJvYcCUtzcB3Yn3GEUXzT3HpXzMVFKGKaJ4vL/9jrcm34smLkF2B1u/0cNQjoOLUoADCcs1DEeWx7BGD@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3feEi4uHWCAfBqK/L8CDd3EHnvdY5YaWgVeNoMKFso5q6dNd
	1kyl5VOZf7P99z01hZY0oIIsPYKd3LBjAcjwMHrMdgFtd4HFXQ1i
X-Gm-Gg: ASbGncskdahp1dcZSH7SjYsHF1TA4e0fclnmteQGtYtRlndxq0fpi+Ub7yU1US6ELnO
	eqU44BymyV55cFzdc8AXuBlnN2CJit2FJcynxR4qjsIfvg4O2+6NFTccA1NQiMlfF3jNAWW1+1m
	6zP1JOSoGgDDpRmir6+o1xQt/9cu9LTPGRnhVDOPLlemIMwZDTKzdcKGPiPt1nO0sm7y0VNV/gj
	HA7xAaLec18hsCerRojH5Xhjs4y2JR7FtxuUvJBxMTz+2cMu+Lv5y20a8LX7xn3bJ5qdYe5l8K0
	93zH/jUNL/ndIZiKAjRsA4XWY1HPzC2x3krrrze5c9OfBn+1+3/MIiTEzmjXevHHJ8FMNNjhye3
	SCt/zWopXXlcgcbp6INMNwEC9l2UGlv4=
X-Google-Smtp-Source: AGHT+IErW+VC7cKEtMFmjVemula5pnmsuaKk1cpS31e1xYdUj8s0o8v1uVlk17v8qniHfkpWedVWsw==
X-Received: by 2002:a17:902:ec86:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-22a8a080701mr97537995ad.31.1743863337699;
        Sat, 05 Apr 2025 07:28:57 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785aea7fsm50296915ad.2.2025.04.05.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 07:28:57 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	stable@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sat,  5 Apr 2025 23:28:32 +0900
Message-Id: <20250405142832.491151-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025040513-bronco-capsule-91aa@gregkh>
References: <2025040513-bronco-capsule-91aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Sat, 5 Apr 2025 14:40:33 +0100, Greg KH wrote:
>On Sat, Apr 05, 2025 at 10:24:58PM +0900, Ryo Takakura wrote:
>> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
>> The register is also accessed from write() callback.
>> 
>> If console were printing and startup()/shutdown() callback
>> gets called, its access to the register could be overwritten.
>> 
>> Add port->lock to startup()/shutdown() callbacks to make sure
>> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
>> write() callback.
>> 
>> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>> 
>> This patch used be part of a series for converting sifive driver to
>> nbcon[0]. It's now sent seperatly as the rest of the series does not
>> need be applied to the stable branch.
>
>That means this is a v2 patch, and you should also send the other patch
>as a v2 as well, right?

Oh yes. I wasn't sure about the versioning for this patch. Let me resend
this patch as v2.
Also for the other patch, as now its sent as a single standalone patch,
I'll resend it as v2.

>thanks,
>
>greg k-h

