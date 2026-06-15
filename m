Return-Path: <stable+bounces-263410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PsCnEjYxMGrcPgUAu9opvQ
	(envelope-from <stable+bounces-263410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:07:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC583688ADB
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:07:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G+DrsmyG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263410-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263410-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3ABD3043FEF
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BB407576;
	Mon, 15 Jun 2026 16:55:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08C406837
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:55:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542532; cv=none; b=tUsbOrjQbjZJl5hPH9CYlQyl6egeF4kJ6daHP6sbWXSrR3yBrTksAMxJtkHtV80qI9QWt8i3NpyoRifDvTzPWp+XLamoJJJAC09nRP63QddVhTXGn9XfHc7PJrDXzBCGg1NzTv8Vwr8MoTwW/fipuE+KqErbF9RwNP9DnG+TMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542532; c=relaxed/simple;
	bh=I0czcqaU9NMs2BP1zo2pCccOyInTDzyoIcCagwGCQa0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=j0vvybBhrAdipmSvvWnEFesQa6fza3WhYlmTNw5428TRzBh+GIlVo3yOYO+mSqMo1zOjG4lIh+NHhBmE2sO67Gh0+gEPPC9mIL5VG5lCmoRXFEtqHUe8UDBsw9qdLRJyjpCWO6CWk/eMkhvZ/+2rMFT0pQks/51HQz11Mbu/6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+DrsmyG; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49222fb062bso26293405e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542529; x=1782147329; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I0czcqaU9NMs2BP1zo2pCccOyInTDzyoIcCagwGCQa0=;
        b=G+DrsmyGxG8auJbnueAyykbiT+VOs4viA5ffOMDhvmJWlJwFmvscSan7NJpptssvTf
         VN3eTgzVb4zJ5zZotjqRO2D8r/rbfhmTfr3G2Bkeu5RtIDWwgqvHryKm4KTwIpYvGY7f
         xknaI0eSBB9ODxaFXAjKtso5KEA8EakBvDgxLO4IpGaJ+ktqGQvpbnzvrbgVPcL1qoIo
         OVzvZcJ4Hv3/kY+5sNpx/bJNoeMTVut2zlCQdqIJkVR8ublKV6bgZqnvyeaojXnzNrbo
         d5l5rObNqllulmYhXDCLQM/tvLRppzxE9FW5DoqEHYG+T2EBrH4ah4gx8RIrL03jZMPo
         K3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542529; x=1782147329;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0czcqaU9NMs2BP1zo2pCccOyInTDzyoIcCagwGCQa0=;
        b=LhauunbjOatSPJOkhigOA3wY4DP3jjxdtofelRw5MynBqmJgBvETvNv75tkbisQ89K
         oYyfFgXTVVR1F+EFPHh0LS6uxWe/9BZ1yUYj+nm+FsN+GHbfW27Mq+FJNZ/zOxMh5F+h
         aLTzKcbJGcwhFRVrYjFOllv31mEdBledmyOIeRTsq5I8DLu2jKYDQBUtxvRNQqIjljeq
         hryDi4K3kY/0u34Pk7KpbeMVBYDTj7dZZxuzzGe638mKGsoxJALUqgpcF+suBEGlUMUE
         oWOTs03tW5CO3wV1jiMjzz2af3v8pnKqkD4UH/E1U5ZM8agLVd5NAaentHZdKQyLB20p
         BHpQ==
X-Gm-Message-State: AOJu0YyTfS5LRX0x/MfHuyUinywdCtMymRYDefbwdY5POKf7KFwtOMit
	w/I5AFkivtWOAjZLguqJWejIxTADpIPrRp86dAD0u3Txfg6xHNTluG8KetYIwo6D
X-Gm-Gg: Acq92OFpU4K94AYMNhA9DiSxA5jD7FL6ZVNkGQr/uMy7pNan1xLqBVXQgO2WbBLz1WS
	OQz004fGp6IEFoZgIf3qyGNTgE891+UHUnE4U80NuCtTG4AubuiyglGUfS+DvJ7gsO9Ois9hudX
	cOW7WzQFtpSWN4hD7LKv5Pa8EWFe58wkx/v7CG7Mk/Ignz3zpYlvAlK+2BYD2x1Ie4j+a250sU0
	S+XtIZOrjm+lN5FYc704QOF9hq8HD3jUaPj3+mwQSE2kcU6o0Q5ed3rZvpEsSs47sgLwqf6tX7S
	/YUhbc9VxeIRQlV0kqF1tjOw0zszM0fZoyFHJCpE9J8QxN+n3/LHtCJ9S2IVXtPRU7XX1KbZsCW
	hXo0s0VSVVArk1b0d4ol7gUlX4VbRSfxJcho5Jvp2JHJovS/DZXWxvhSDU5Wt+0+oKj4ZgZ4lLc
	P178ddUovVfVpuO4d3Vy6aaMzyTaj3oiTKNusawgCz02EfLQKh7tf0frwS
X-Received: by 2002:a05:600c:3b03:b0:492:1e7f:d426 with SMTP id 5b1f17b1804b1-4922ff72ab6mr599085e9.2.1781542529291;
        Mon, 15 Jun 2026 09:55:29 -0700 (PDT)
Received: from DESKTOP-LAN43DA ([39.46.252.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm36643165f8f.8.2026.06.15.09.55.28
        for <stable@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2026 09:55:28 -0700 (PDT)
Message-ID: <6a302e80.d5af3cef.1ca29d.82dd@mx.google.com>
Date: Mon, 15 Jun 2026 09:55:28 -0700 (PDT)
X-Google-Original-Date: 15 Jun 2026 12:55:28 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: theosilas.mypackagingpro@gmail.com
To: stable@vger.kernel.org
Subject: Customized Bags and Boxes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263410-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[theosilasmypackagingpro@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[theosilasmypackagingpro@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC583688ADB

SGksDQoNCldlIGFyZSBhIHBhY2thZ2luZyBjb21wYW55IHNwZWNpYWxpemluZyBpbiBj
dXN0b21pemVkIGJveGVzIGFuZCBsYWJlbHMgaW4gYWxsIHNpemVzLCBtYXRlcmlhbHMs
IGFuZCBzdHlsZXMuIFdlIG9mZmVyIHR1Y2sgYm94ZXMsIHJpZ2lkIGJveGVzLCBtYWls
ZXIgYm94ZXMsIHJldGFpbCBib3hlcywgc2hvcHBpbmcgYmFncywgYW5kIGEgd2lkZSBy
YW5nZSBvZiBvdGhlciBwYWNrYWdpbmcuDQoNClBsZWFzZSBzaGFyZSB5b3VyIHBhY2th
Z2luZyBkZXRhaWxzIChib3ggc2l6ZSwgcXVhbnRpdHksIGFuZCBzdHlsZSksIGFuZCB3
ZeKAmWxsIGJlIGhhcHB5IHRvIGFzc2lzdCB5b3UuIFdlIGFsc28gcHJvdmlkZSBkZXNp
Z24gYXNzaXN0YW5jZS4NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IHF1ZXN0
aW9ucyBvciBqb2IgdGhhdCB5b3Ugd291bGQgbGlrZSB0byB0cnkgdXMgb24uDQoNCkJl
c3QgcmVnYXJkcywNClRoZW8gU2lsYXMNCk1hcmtldGluZyBFeGVjdXRpdmUNCk15IFBh
Y2thZ2luZyBQcm8u


