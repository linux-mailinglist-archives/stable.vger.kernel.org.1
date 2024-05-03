Return-Path: <stable+bounces-43038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3A98BB433
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 21:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4DB23215
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BA158A16;
	Fri,  3 May 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSSv8KLx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E032157E9B
	for <stable@vger.kernel.org>; Fri,  3 May 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764972; cv=none; b=WOu5oMHnCY01uFFXaspETW/1UyTujrClLJnEoJX2BOQOGc9Sf/DMjG2ruYUIDP32v7pqA3ecYctBt123gHuhabfWc4eXVhrPiTDFXBMb9Wr5lN/5W5UjVQmk4lhrRyAhDPKAdLHdGV+FKNrymXi+zExznq/M4xBNnnOO6tggdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764972; c=relaxed/simple;
	bh=hBfweb+GcZYEr5/bxAzp1k3NSgb+RSkSW+CIbLIqrbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En8ShkRaoXNIw0hSgn4sLZbsmpoF9/VLC20aXUDELlfzN0+gXA0U0pOpTZIcwykmX8lkZwuZyIa/h4fcc4XsfYo+xBzbp4At75IMXg6vbYKIPZbhsaSTBi1NbVQwbcnQdb+p4Iewu4H16GUtY5MaCHvIE/CPlN6l6H6HIlbV6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YSSv8KLx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e65a1370b7so101895ad.3
        for <stable@vger.kernel.org>; Fri, 03 May 2024 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714764970; x=1715369770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9YtwqoetoZnr/s/Q6BCYI3bgLi2hYXmlOhnf91tPw=;
        b=YSSv8KLxJoK47DH/msAbivGhhocXB4IyR2/7CFlwZ7W4/ft8u66iShjjWVki8/Mbxl
         tj6zLjb0YlrIVPHvnQ3HtFpySbQHdzmE0AfbG3uLeQAcBaJodQEEQd7+xo8PwBYIJdjN
         nvppszCDSVo+RvJpIVbJiWV20IF6wknylCNQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764970; x=1715369770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS9YtwqoetoZnr/s/Q6BCYI3bgLi2hYXmlOhnf91tPw=;
        b=UZ/2q138cdK8BAQeETJ57iPrvaZ4vZvi/af6KNLqqnE3uZyJBwah+8dgYOvRjlubhW
         gXpcXF2Duaw+CIHoAgeUx6A4+6fK14ajQsDUa/iN+jOK0dFE9PIibVlLGuKmoSAcL+dm
         TdJmMsyWqBeZA6UYGQUM6o2BYU/dHHPlN8GaNBQyzIwwPqnXim7hYb02g3KwDr4YKsvg
         I5w3jSPHj0Wj3o+J21t9SF4NZdkgovHzfQc0qhIv4yJLIvlfFEgj8hLCIVE8mqKJUA89
         mEpdQrZSPrcCbOIFuRIMWahvPaJu9RLqT3Gi7rjWiItIW/gp2xahUnb3SFnoa35uUy66
         A30Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVS4/df+svPq2zbJX0+fUoRTz/O2qkYU22Hw43oc80ER+MMlzwLsRtEWuSOfulv/iPzdSwZHQcC+6c4DkM0qzsfNAmxto/
X-Gm-Message-State: AOJu0Yze2hVRtjQ4Zex2i8RDha0GWNLfLJQyCbRcUc09bdFZbIQDaoWL
	EkmqOBSn+T7m4Q1UZh5lKRE6eXH+83SqufeQOPobH6b0rDxo/9ytWE2fgkbbEw==
X-Google-Smtp-Source: AGHT+IFC/8F9Ovu7bGHhulDN2Zn/p+vJxATDZ0By1DvhsuyQKNVhwpT8z16+LTSxWkjHZvQ2PNzCfg==
X-Received: by 2002:a17:902:f70d:b0:1e2:81c1:b35e with SMTP id h13-20020a170902f70d00b001e281c1b35emr4853176plo.54.1714764969845;
        Fri, 03 May 2024 12:36:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e2c8bc6bebsm3716248plb.81.2024.05.03.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:36:09 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexander Popov <alex.popov@linux.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Date: Fri,  3 May 2024 12:35:48 -0700
Message-Id: <171476494554.2457276.4385338995352491886.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 15:44:09 +0200, Thomas Weißschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] stackleak: don't modify ctl_table argument
      https://git.kernel.org/kees/c/0e148d3cca0d

Take care,

-- 
Kees Cook


