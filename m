Return-Path: <stable+bounces-231150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBBdEipTymn27gUAu9opvQ
	(envelope-from <stable+bounces-231150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BE35989C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEFFC30334F9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B13B637E;
	Mon, 30 Mar 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWuRtQ+N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984E3B5851
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866194; cv=none; b=sqp6z3t0gccxHk48XYOjGwsIyDgdAKEQHb5aFAlmVKGLcHFZaGqOdAJebtVNidknP4rlUS2OKbUkjZeVjGI7YE4ByJ3LnuKUrpTVjP4eORVZVUl7bdkVTJJcpDb2525G46NDoCk0csfQu+Z44OrhcOKpjslR/C5nrjIw2xWhjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866194; c=relaxed/simple;
	bh=2OLJ94HJlikgcrXqeZIl7OisNTmViXdEeC5UBZ+pjOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wvc4cCzeM+53cjsJV0YZni7w8Qk3qtT6WcmtYAc0Zem+KVIx6Xe7T4Be/AznMXUMmKRWZ3c1OxVLGvwkc5WKot4O2KgHC9R8HEkynRtINth7eY3Xsz2GbexCzQJEa71D0KlFJZCROWXnpZj+6FSfpwceamim4QIWNDfIYobST7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWuRtQ+N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2165462b3a.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774866192; x=1775470992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/SA3PxxzFOYvhnPnfnyUd8N6LpFu9KYx7x1Q4uLkmQ=;
        b=GWuRtQ+N3/ZHQYDY1SRg/nhWJVMV5pcvEmkEgMwldT1nHgfgoe7BtDEqn03L/SXX2i
         TJSfwLsJrhKscuQBzG4El48F+ISBbER58NvOHRXthScCVw3k0fKcwQu4pvy61YUPwF54
         RbgGJvTMwW+rK/z9IDgvWHOBcOsg1X8A2nDLOhP8aCKiw0gD0S2X5hegl2Agaf8a6VhU
         LgG2fnkC/eKroP9IU2T58/F5m9xcBEBPSAnkLQLIsNRXeHGtMtSJtPTB6YHCbOjSDEbG
         Ihy6QEGVli1vxCe+8ThxxUIYnsVtM4TN1sqgwMVwRzyMsNwNId58Y1YEMxtFsu3CZgfs
         WLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774866192; x=1775470992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/SA3PxxzFOYvhnPnfnyUd8N6LpFu9KYx7x1Q4uLkmQ=;
        b=gKt6OQaPdw5IiEqVYYkjWR0szpjcQkwt6Y5U0QsjwX8GUMH2LiHJqMnyGRI9Oh4sKb
         vAp5wtnrr4ip3Lat2h08zskiv+uWZVZOQAyr2/up3HvdnC2oPIwhdXFEWRdH9ddhzqKN
         HeYVM/oztVP55qwLU/sDzWlVGDNNUFeKYFI8W5gMYv1eVQtm9kBihidIfjsNrHCIKS6r
         F2LwB0R7oS3yyw1s+jupaylriGwdSczjYWnWiDcJSa/I5J8reyU/sdlyZSyjJT7Hy3fp
         GWUvWsdiNIx1kINHdKQjAc/vO+qBd28YhomnudVHtWNq98FiEddvTjiF+zV+lfZ9ZQlo
         H/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUkkPse6WIIXiaPjvbFwcN+fOQOOa2cri+V/hTB8Q98E4hB0kP2JzX/XBBjFRbwGXMiv/UzqHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThSb7ik0tkQ6RIDLbXu5SuZlcd4nQLZ50O3vkwavRCkPk3gb4
	T7mHyt5MYzssv4bTK4Ozh7u3q/H2q1l7RmomwmwL2iFlQDzN2AjDYTEK
X-Gm-Gg: ATEYQzzOS8Mas23tMLiyrv1a3q9Gp0jizeaqBUWmp8AzB6tKav95vRUWEnC7i2FYpKC
	HYPkiFWj/an/ydxUSzTyYsycFfxVq6qOWBPRgQwuTuIcjsc4bLHxET5iGFHr807b9fV8qaVFubv
	l1HIsrQ+zuq55z12lrQc8hhvXS7JbBCTg60LwPLFFstQcImAcBz+vwekmcOhrchVvk0+AVAZ3SL
	M3XmGw/fD/k9FPy82gVdtGoH6jvPDbc4Dpwk00OxYq7jekG9SS4ectGufzxrqav2dkDw6MQqSIf
	EGlpCUsjEYTqZJaA31COKDNAm3WEJ2mQG38eWPJBIGy4QOLPFeVkf7IWxCQT9l7kKquVMtdlyNH
	kuX34iPIIW+HlIMNgVDeIUbDxepYmIgn0p/wXOm57FD/cIJJBZUjPNGmPY1zEluCPKkaH3wHo6C
	zVVA6CkSRF3KN+huMFLgeMpFB5xvhJAvk=
X-Received: by 2002:a05:6a00:b4d:b0:82c:9266:624b with SMTP id d2e1a72fcca58-82c960a3472mr11682638b3a.47.1774866192040;
        Mon, 30 Mar 2026 03:23:12 -0700 (PDT)
Received: from ArchLinux ([43.226.29.240])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82ca85fc72asm6948403b3a.48.2026.03.30.03.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:23:11 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Biswapriyo Nath <nathbappai@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Young <sean@mess.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Martin Botka <martin.botka@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-clk@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] Add vibrator, IR transmitter and USB-C handling in xiaomi-ginkgo
Date: Mon, 30 Mar 2026 10:22:55 +0000
Message-ID: <20260330102256.17631-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329-ginkgo-add-usb-ir-vib-v2-0-870e0745e55e@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231150-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathbappai@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793BE35989C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 04:47:55 +0000 Biswapriyo Nath <nathbappai@gmail.com> wrote:

> This patch series add support for various components in Xiaomi Redmi
> Note 8.
> 

v3 of this patch series was sent here[1].

[1]: https://lore.kernel.org/linux-arm-msm/20260330-ginkgo-add-usb-ir-vib-v3-0-c4b778b0d7f8@gmail.com/


