Return-Path: <stable+bounces-160362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64473AFB20D
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373153BC927
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E18A1E9B3D;
	Mon,  7 Jul 2025 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IMzbot9a"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A3291C0D;
	Mon,  7 Jul 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886734; cv=none; b=NXYI6hGdnZWExNaoxIcD1ApyPJvoB8JzW/OI5GRFlHx7kiLpPIZKB74yZSXU/IH5B2bNmwXqtIi1zwqybLmcytVIVKnyhHKof+Ig0aocg8oBLOBQyyxdEBPS+AYrf32mv3xlKM0XF4psNhizA6lscmoTCjbnbzlQy/e5C1SdmC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886734; c=relaxed/simple;
	bh=RHdoYq7iuuJpVddk5TIX2AFHoby0iT8ppcZVUu6DUQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R2UBsW8OqtQpPGmwOej0QP7h5Y8rnJa3WBwm+9BZQ5JqMBsJiIiFGGIVU/XdQNGYjVA6F+fHxCvwm993cGAfozIm2B/CHDZfduVverho8ML8cY8z3CA+l1O7tKeY95UFYSWzoI/HtMBHT/SF13DhzKymK8+4vq+3RAh9IBjBh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IMzbot9a; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C065204CA;
	Mon,  7 Jul 2025 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751886730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2IuGLoN2z6uUxTC0PrzTB7ZmiLrMY5Ne3GgAeVwppg=;
	b=IMzbot9aBAhY+A1it6LpZpCDyjxBoQIEZACu8HSiFtwHItU4PwlkuJ2jMdd3nFYTVyqrQ7
	g58FUCdJhatxHJwhIByjBcT8m1wZowSJzo107blG5b5DB2bimuNIiUEi1sNRZDZdwb6kWp
	0lzJB2OZyDTuhKH/989quxd98EclsS8hpjf+OCBMQ4UzFP03vc9iNzg+xZ4gi7vjTgVMtE
	3diL1I5cvtehD9HFWbk/zakM6rw2dN9U7BtoRVIV0mNHaEKzfusG7E/HhatCo9cS2zuOS8
	G4nVxrThkkntyGQMBUXKrvTNtrh10EzzaVp5Rrmzeg2YX6W2RHaALEOuRc/FSw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250704-drm-bridge-alloc-fix-tc358767-regression-v2-1-ec0e511bedd0@bootlin.com>
References: <20250704-drm-bridge-alloc-fix-tc358767-regression-v2-1-ec0e511bedd0@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: tc358767: fix uninitialized variable
 regression
Message-Id: <175188670931.81272.9699272605011757855.b4-ty@bootlin.com>
Date: Mon, 07 Jul 2025 13:11:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieefvdehvedvgeeftedugeetudevuedvffekhedvfeetkeduleelgeevudffieeinecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegtohhlihhnrdhirdhkihhnghesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhov
 hesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com


On Fri, 04 Jul 2025 01:30:18 +0200, Luca Ceresoli wrote:
> Commit a59a27176914 ("drm/bridge: tc358767: convert to
> devm_drm_bridge_alloc() API") split tc_probe_bridge_endpoint() in two
> functions, thus duplicating the loop over the endpoints in each of those
> functions. However it missed duplicating the of_graph_parse_endpoint() call
> which initializes the struct of_endpoint, resulting in an uninitialized
> read.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: tc358767: fix uninitialized variable regression
      commit: cb863540e7c756abe7e709673a3e073c6a7aa8c0

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


