Return-Path: <stable+bounces-249893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHKGJWWjDWq10QUAu9opvQ
	(envelope-from <stable+bounces-249893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:04:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C658D3B9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75529321D1DE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CCA33345A;
	Wed, 20 May 2026 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiqW7xEj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F927370AE7
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277322; cv=none; b=UrP4GO3mBE1vXsuCsz4Ffhtfte0XHboX/rgtXJSEy0zpwBGc7WubgSArX3h947mIe87sSTtHudePX4ZWxOz1dhqjlPCih3aqPcF43ri6YOZEDZWJIP1Ut8dyojkwHZNNKJX5itURwYyJL6Blq8jFgsDdarOgeLjJVV8X+REvNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277322; c=relaxed/simple;
	bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpI7vXieFQRUZEGhjisyT/09/qeRTeCce/dt4Ql+eQlG2gbeG10xSGnHECsjjebMGfUINsxD3X49gQIO6niHoWt4h0ogkHYav22c3TygybGWwb+XBx28sttHh9q7nO7UwBmnz4UGK/mBfl4+E4algBQRPP1kNvP8ON2lt69y+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiqW7xEj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393933b8c6dso5376121fa.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277319; x=1779882119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=YiqW7xEj50cSSpYM6VIXYULIrNoSdZQfPwfX5ODEB+C/Oy9gPd7FbJhTOcA1EEC0V1
         /dJW42TRenhA0X/r9I0JgGa/qbdKtTMbfVRgF+iuk/h1txO5wZzwhP2LrzGNI65h0MIr
         2E+soIU+/sQJK2it196VxY0QlG874HiHwP+0lGNyTa5zb8APuB8GidBL03m7vR3+UUOF
         fflHbVx1wotWa/5bFjIT+y1PhwFNPB2ZlMW8VnA0R0/FWWqMwUUx+iqGlFbVDrm9XEwg
         t5riX50J7yxNu3HgtdNXYEC5+9MdBOwUz9UULJ69fh6HI09B+R7hXmveBvqvW0jpWpgK
         8DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277319; x=1779882119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=rS9natEe0o/NRc/8/92z6AOOBYYg4RO5YcOafGVpdJT0YKnVLD8OR5BOxeSlCUHmuX
         ef9xlRuOYUvz4ML7ca+M+CQ12cG+DhjTzHnAkDIWLexlayEkUxLR2wjqDhX1Me+VZpdy
         v8I8M4dBtUCrvR6zProsrKLMVjEgKJWBn0+G+ZY2X3xj96uRvygm6Ni+9yIRbhMs55Da
         7EmUFLJ7uRPuwapxdKPSl50bKhO8puUlbm0wU1I5UbwKirf14XjWTOIo3DU3wnwdYURR
         IecnYe9Gf5zAoY/bDsHgZ2d6DieYa/19SrTrYyo8LV9Wrb4f6Wgv2lF4gJnkQJ7txpPI
         SriA==
X-Forwarded-Encrypted: i=1; AFNElJ+i5H8MsIlPQ2XnV8S117+a5duZY0NKSF4GxKfKO/FAOMm20VvZKdj4Yc655st0CeICfhYEw6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lKa1s4lbQnLCzT697Xt4rwsFjPL6RWGZX2k6SlwLwUzaPte0
	PmBa+P76UW2fNBcYqWovQD6g7AtWpj5rk3wuTrce0VamaSsw45WQUcfV
X-Gm-Gg: Acq92OHfuwI0Gx8lIANfaQuYYmKpEQU117KYccqwr+2t0g4+KwXkTJ60oxDaZWAAgLR
	cdUr728p7LVHqsd/ZEi8YvvN/cfic7gwqgvy3npuabacgqEP+Af5EPy6GH4wbQ05iD1jTAnTE9G
	mKnA2dzSlvKEqazc/qhBc0LNSN2hdlfqPoPuiy5LNoBcp30pDqt4We+w/hS096WRXiIEzf57nAk
	s0aZ2GhHl6r8uBrrmmSGjqVoXbFoYothSX0VNg+jNBjBvbaBQU8VIwt8SZ5k2P+uCQpIFr41/kp
	GSkLoIUPs3NGbqWiFOHQjlSEH6cj7zg/m69zn9bRijVlK8rpN0idaLQPlpp86prWEPq9glignWM
	MVPX9W6AQV7z70I2YcvENWXNWN6b18BnJMYysp3gGRQf/BJb57qKTOftDU4kAlQ5n3zSc/pou2g
	VI/9ZULb1RQb+UjOAwj+3rOHQH9Gpvod82Zxjfp29p+0+/Tq4=
X-Received: by 2002:a05:6512:1254:b0:5a8:7c42:bebe with SMTP id 2adb3069b0e04-5aa0e97f14emr3667233e87.4.1779277319327;
        Wed, 20 May 2026 04:41:59 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc39fsm4882533e87.49.2026.05.20.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:41:58 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: wbg@kernel.org,
	Jonathan.Cameron@huawei.com,
	raymond.tan@intel.com,
	balbi@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
Date: Wed, 20 May 2026 16:41:44 +0500
Message-Id: <20260520114144.14830-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
References: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,intel.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249893-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	SINGLE_SHORT_PART(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1E1C658D3B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>

