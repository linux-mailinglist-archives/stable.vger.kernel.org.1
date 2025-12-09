Return-Path: <stable+bounces-200433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC7CAEC01
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 03:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C44B73016368
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 02:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9626ED40;
	Tue,  9 Dec 2025 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IL6S2tLA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1620FAAB
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765248320; cv=none; b=PULhVsuK0SaOrK4jbx2aqKtgRQWiWSAdMxF/h7vkN67IfQdBWKrK2mpwSfntNjbjMHN6S0Ywb9So/NQiHxJyS5RxkdNN8QkK6PRHKa4TkEMFVQLv9t5sS98E4JhkBy/avysLAI7dvVyTwJzv/ZvsI7R4uxjdaLmHe/hJZAdn2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765248320; c=relaxed/simple;
	bh=FyJkIggRHO8k4F9Tvk0TheBChDEYPt1mFUPjqtLH6+s=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSDhvmyQ2DRtvh2NttR+hYqPPvbauH1jxFxA/Wqts7gHU1K2ZSuHkx77swUFITYsCE36TsDg5Aetx74vhdxEJm2VuYhl1/zeSFRM3RBYvuE+c7Ijj3H/PCk2fJsh+TLv8nmFG0BYSvLlaC4zAoNrKvgQ7LeexArryxttQjF4SQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IL6S2tLA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42f762198cbso3306815f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 18:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765248316; x=1765853116; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyJkIggRHO8k4F9Tvk0TheBChDEYPt1mFUPjqtLH6+s=;
        b=IL6S2tLAlVUfo13gqueYPheYlJnmRkb79/zriS6LbhHfd+ZjWFH3EJOc/SPuHjVazf
         9iua8o+cgLMIDdgbU6CY89bYoK8aovulKO1W7Mj+1UM+IsGwA+ihgizSEOwegsJgXhPr
         jWYsXIhgqcswd+KtosCYghaXwgaKTHS5RTpX/B9HAFhQPiXUokZ0d+FZc8fLqnUaJxln
         ESlWq3T0PP/EgQWtOzkOkmfgD59PvC7fbUURahXEL/CvSxGZkH95bfPKiNMRJmA7Ehax
         470+K2LONzSWj96FgrJ5on0wFja39qCV/BuXsE9a6T5BTY5RoliW3Z+piRwaOUq5TVfS
         1lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765248316; x=1765853116;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyJkIggRHO8k4F9Tvk0TheBChDEYPt1mFUPjqtLH6+s=;
        b=CExx6Ir/R6UkL3xL0HSEz1PZChsl2v2XmCVmL4d/0ZSyh+xNm2tRE5j90IvquD320Q
         Vnybicfu6E0MSyn7b2xedL7emkuJTfImIQJPb/fVjW7jFu5kiY2xSiKWtaTk8ON9ss/5
         Oq2VeN6YPOc3xOsAkeLCYzjOQ+HdIwEgjbzEQJ8BPNFFGF/9HdtcnKurG0NADTgPTjEE
         /j0zsLdPmTw+2mT07E2gvYTCjv8q4RksJNi0jBIjCeuhu2OjrmRJtLZci48gjpQdiDEg
         GfIU3KQiA7durRcfgkj1qguX+dVUFuSfysjX3JaAil0eCiMpla2iVBuQobDMC0iBwfVn
         Ucrw==
X-Forwarded-Encrypted: i=1; AJvYcCWL4o5LF6smC0BYmVd6nA6p/lxG7wxwUMaVO1w4l4CuDtfCEETxFvoLBqSVfeynJronVSEhqoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeAK8hXen2q8kbCLHO5I9knY1hvyVZWEKf1kiLZKu1GXiItgQ
	uDhGtnVg2lL5rE+e7aaHGbdyVnPzpacVW0y9avvDWws/bLJxuHuBtbhMuZzk0HK1D3q4r8h+ABB
	8bJgMiWE=
X-Gm-Gg: ASbGncugefdv1wFIPG1dygRIHk2UOrHaUgCzrEZpUskMBhQ3/ZGsUIk/idM6Ecz+MK2
	isJZRgq8omauHikDZt9+2xovWnoasQ6kc1W+DzCwNtqKa72it/WP86sOv1dwICSqHGL3sl4WhGA
	B0pnWv3gCRIIfzZpU+ZKw0nv9q0GUQ7JzejYbhoLw6hqR1F2MVQLwsonXLyFYTyPgEE52jFjcvv
	l85LE4PFIWJ+j+9UIov74kekZT+uSLf0UV6meWK3FzC3tuYqKNEIFJgJQdBClNH//N9pcWh8+3x
	C2CWhHy5NpwQ1iV6ZyPdIjlfRIIzM5buYrKlwO+HGiadAWOG6EdF5yvNy/XQH7pAmYSpdJPx/+T
	U7mGDmE78DybM6kM1EdpayT6IH1G6/qnfqNKFqdcoS+1i7sy7FG/IBX44BK4t8qOrfzlYA37J/8
	AYPPpDn036vTcki/IhiNfgTL6H8tXUuZZEjsbY
X-Google-Smtp-Source: AGHT+IHA2tNzr0hrI3Z29HOwDVkYHI9K+/tsw2cyKAuGVkhtfihzDsbadS1bKj+RNxjSJFFbjjjhJA==
X-Received: by 2002:a05:6000:2409:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42f89f0be15mr9000225f8f.21.1765248316505;
        Mon, 08 Dec 2025 18:45:16 -0800 (PST)
Received: from r1chard (36-228-74-249.dynamic-ip.hinet.net. [36.228.74.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222478sm28299872f8f.20.2025.12.08.18.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:45:16 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Tue, 9 Dec 2025 10:45:06 +0800
To: linux-efi@vger.kernel.org, ardb@kernel.org
Cc: jarkko@kernel.org, James.Bottomley@hansenpartnership.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	liuzixing@hygon.cn, Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH V6] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
Message-ID: <aTeNIqZnpYWhjJ1Q@r1chard>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)

What is the current status of this patch?
Link: https://lore.kernel.org/lkml/1752290685-22164-1-git-send-email-yangge1116@126.com/

Best Regards,
Richard Lyu

