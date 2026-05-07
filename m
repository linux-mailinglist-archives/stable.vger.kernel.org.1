Return-Path: <stable+bounces-244487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MlqB9UJ/GnvKAAAu9opvQ
	(envelope-from <stable+bounces-244487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:41:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD64E2AF7
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551D43017C25
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 03:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863E2E5B21;
	Thu,  7 May 2026 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCxJdmIN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D92D8771
	for <stable@vger.kernel.org>; Thu,  7 May 2026 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778125263; cv=none; b=mJamE3KRDGRIRllRbIoVsVU/bNDzgAYCwUsPdc4EyA4yItw7W07uzxluJ8iz92SGc4ivjfzPmqFU9JikGCwtw7h/Y7M/r4iei+RHVBSZlonPRfaXUX6c0d2TjCStXPZ4zvZp7bqpKiq3fPIiWu1trmgN8q/BAhCB2axdVirla5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778125263; c=relaxed/simple;
	bh=eYcgf+oz5hbuznP2Lx2/af6e4LKOlFWw/HZ70VnGKjk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gcOwUZiI7PeLV6MbRTMFqbih5E70VxeER8ygloLck9/3TaUFurFPXtFesR8Yi5psSKPBJUEsEKxDer6TioNtQBMMtBm8ad8/YOAos9HACJFnTegoS7IKBDzz513mh/TPNJ+kEt5G1hWDgFAdnLnQMv1EtBS8oKFXNAkd+6tOqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCxJdmIN; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso160741eec.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 20:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778125261; x=1778730061; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgW6TooXSeb0tZLK2I82glQ6UXGdUU/uKulCwpNUrQs=;
        b=XCxJdmINsfziPF92BupJ5JrSWZqgqIVsrLdPnj/QrNn2oRq8htuJfefyC2t+U6hgTj
         joSUlQSVWG1PhKrIE13uW6/wDVCbxjEcK0zT53jFisQauGDIWmKUo4bUeX7NjE59wB4m
         RGlMbkoKD82XUV0N2kwjn68PxqH4Ux2mPXlpP5L6Fz48FeGcXGu/Mbxr9WFLgGMw8rJ5
         lTzN8zHH0VfH3Hq/Puy3CeqckJOlXEXvQFBfx45L674gPSDhLZbi37RK0qkxDwyl7OIA
         BYbep92MaI6FQxEzWj5gwJSSV6Ak8/cezTFIXOaMv6caKoqu1uDFPdV9e0KRJxjYvj8f
         Vnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778125261; x=1778730061;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgW6TooXSeb0tZLK2I82glQ6UXGdUU/uKulCwpNUrQs=;
        b=PPoL3fLzcOo0BTulPgnKs/ggzlkNXS+JzkJC+rWArF6sWU425o/wwEezR7bkeS2qmd
         ypDEnP5QFi2TqRetArfJmVGZKQR8O+2qauL/+QGWGHDG/6LgkQnQhbjfzd4/wvQLTllY
         s62jXKzV74v0bZTtYoMsrguG7kYYlso3VVxyRsseksmF1BtecZmb5xTO8aH9tHLPrbQe
         0fzEVZtD4Alx2QwpOZPbLcS600DTGBRpxYo0Xq4xvFi2YPaylRffZFZslO/NfsRYVArS
         EBGviUirpDuh4Hjs66gUcgvWdUvyZbpAJ+ktzYjWs231XQnbZ3gyJr2qveEjPhdYm9Ld
         CLKA==
X-Forwarded-Encrypted: i=1; AFNElJ/IF2MNNh9Orx8zZqlcRYBcH+Tk5Nc5wTCOz6XYD9b5F/JxnEbZeGuAZ+MXO1I5wCnBI5TnLCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xY5cUXiiJXBHiOCu1u4T45CN6ZGaWvwAAaHK3yuWRaB66LrA
	W+MsQPitLAfKjl1b9cRVNgNigbCm3Mp9ne6Y09VpcOELzFZdWlxdYL9q
X-Gm-Gg: AeBDiesKwc3AGjc3qsjgs3JTL1CndvrsR2uKLmRP9hN88UeikeCb7+hSBQkfXAlMowx
	0Md0YufiYqy8WuLtnRWytqXjpWoScNS7UANDjk6o2GN1vgBaEanSWYnJaqiikc/IORcZrIjLP7S
	IwW3i9s8BMrlwe60cJOxYPyerwKKyOlPqPqSzGxcGHKPwr8vaCYKzwZt6hiVAst9iy6a9DgZChe
	xW4IueYbKxoFErfuhOvUlWPW2gl1tagzxdznmX0PZCjEpbZ2VizfT1uKGu4WaQLU9T0nKZhBxYc
	ddmoJn2/FkRYgPkm3vEHjS2EV9a9oKyaJYlHOF9JNGBzYBfH2UngWzUYaZk6zkRA/akoZgQrDe2
	QU/QWpaszMMo3aVygDgrxGCtfgbhiZ44nfbFEGn/0K3ZpgurrYV77X3WPpAQln+cz4ei1IBHlIm
	YDHRt2TRpJWeA+Pvd5IUuIYkPo2x7OCIhNgVatczSh2cbw2/2T/jkXTFNiCrYTDZHspjbPVHYa0
	RdzcxwjZV5f
X-Received: by 2002:a05:7300:cc90:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2f549f5f684mr1845914eec.19.1778125260877;
        Wed, 06 May 2026 20:41:00 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm6882677eec.26.2026.05.06.20.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 20:41:00 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH 0/2] ALSA: usb-audio: Fix endpoint-extra bounds checks in
 USB MIDI parsers
Date: Thu, 07 May 2026 00:40:50 -0300
Message-Id: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwrCQAwA0KuUrA3U6UfwKuKimaQawUyZdEQov
 bujLt/mbeCSVRzOzQZZXuqarOJ4aCDeJ7sJKldDaMPY9qHD4oRPZUUxXpLaih4nQ0rF2LHj8US
 BhrkfItRjyTLr+/dfrn97oYfE9ZvCvn8AhVEGCoEAAAA=
X-Change-ID: 20260423-usb-midi-endpoint-scan-bounds-3d67b2b5f45c
To: Takashi Iwai <tiwai@suse.com>, Andreas Steinmetz <ast@domdv.de>, 
 Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=eYcgf+oz5hbuznP2Lx2/af6e4LKOlFWw/HZ70VnGKjk=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJl/OE9eOnL5lO+FyOJFMWdby322eTVlcZmm+kzpOHVIW
 CazdL52RykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAExkhi0jw7f6rWkbBfpStoWq
 qy8w2MSqz3ebUeGqgsfHg+tTd2tUtzEyNDtutpt+Lu6HaJJH1uGTbY6PLGr7PYpnx1fHS2w49ze
 eEwA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 75AD64E2AF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244487-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Both the legacy USB MIDI and USB MIDI 2.0 endpoint descriptor
walkers can return a class-specific endpoint descriptor without
first checking that bLength fits in the remaining endpoint-extra
scan.

The later parsers validate the internal flexible-array sizes
before reading baAssocJackID[] or baAssoGrpTrmBlkID[], but they
still trust the descriptor returned by the walker. A malformed
device can therefore make the parser consume bytes past
the walked descriptor span.

- Patch 1 bounds the legacy MIDI endpoint descriptor walk.
- Patch 2 applies the same fix to the MIDI 2.0 endpoint descriptor walk.

No behavior changes for valid devices; malformed endpoint-extra descriptors
are now rejected during parsing instead.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Cássio Gabriel (2):
      ALSA: usb-audio: Bound MIDI endpoint descriptor scans
      ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor scans

 sound/usb/midi.c  | 12 +++++++-----
 sound/usb/midi2.c | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)
---
base-commit: 627f14c46d507a5f14a159d27c0042a6811903d6
change-id: 20260423-usb-midi-endpoint-scan-bounds-3d67b2b5f45c

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


