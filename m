Return-Path: <stable+bounces-223682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PtBNoXhrmmoJgIAu9opvQ
	(envelope-from <stable+bounces-223682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:04:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB723B396
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F079C3023A9F
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF723D75D2;
	Mon,  9 Mar 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZexH5tXO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E93D5258
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068522; cv=none; b=faSU25reOIxdsuQVYHF/zUPW+9xwf0OvSawirJYlYoIid9bj0WzpIUwDcqLRNQ1gX9MaFqdz3ir5FjnnHfANxWLv1B4gntf/ZCB3z2G+aAfkcgBoTk0F7QizGgbPGvcfHjqnURsQBB/Ye0UCI2YBgc6Nw3LbWbd7jS5slOPHFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068522; c=relaxed/simple;
	bh=gztHX5oQ3fyBjxMmTbV5Rxprhn4C04hApGEvrDJ0n3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f+f7tiNtiumyU/P8Zz/lW2mOrZdOz/nXObARJ3WTlRHLzVYkYeCSunG0COINfJfqAAUKnrwt0wO6XnYwi0hzt1u30O0VWOapdDT+j16inzEvyoqMDbtnnGDEoBnYFHJMRDdaGZI9SSGaQc1L7P7Vesz4nZnDVAJrx8/Z+fBG/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZexH5tXO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a40273544so23085331fa.2
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773068518; x=1773673318; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55ZaSS6rivKHPgxpbt+2mikvVBcoH0ldDIdH6+NFR6A=;
        b=ZexH5tXO5u/zojZOU3RGCFPLpu88TYQJHQ8nk1Jio+46fMW3QYB1CYnDsZzd9oyRGY
         xaDQMBAiWR+7aP0Mg0DsaItvvypYhlAFWrAUF7pziE47vU/UYPyRURyyI4G667iOtWUc
         Z0b8gAjwMM/ikDnKIeL2VE5gldhQ9owO9bc4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068518; x=1773673318;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55ZaSS6rivKHPgxpbt+2mikvVBcoH0ldDIdH6+NFR6A=;
        b=w0GODS7sA3PErNZBrrQ7yMXcmfZxIPWtVFThZqlzCJGg2FGR5tg6p2PVq07PoOIK0q
         ijgUzBrjUelmrdOj5F0Tovd9vOBtKOunYxinFGVGeOyHE+GR7wTtXj6W8m9BZ6QV5L4L
         Dy9knhl4xH9vLCXqGODE3UuYosaqKetiov6OV/MHn3SUq05prFPvFc4+fq9q2Cn+kWpr
         BPSsYOgXQuOZghiu/7Y0WbiT9cLP6Cf4oltvwJs8q8x9EKxTJ+rxL1L5JBq+r0Cfm1wV
         thQnZjcZ15lptV7WUP9l8KhxyFCjZPQBR598ImVhc9GsVJMj1EeWUJx+4yKoL7FrIuGT
         LzNw==
X-Forwarded-Encrypted: i=1; AJvYcCXuNQArfM4GBOrmiMC8IdM1ggUWPAf0QCnhdHA6tPGw1TWeByw1GJNZ4w7LZKZCNW9VVei1NgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPVraTCd/T1Uyp2ZOyLtwJtYabdokknlO+VP4KJxNx7VQZqZI
	lcA61y4oDByGl62tq/f4yLHlsnSBydaNWTPPbHyoQgBMOmjUB1eu49KJvgBYhou7TA==
X-Gm-Gg: ATEYQzw8hg5ye1EDrf4HedNUsq2V9Z8zH/Rd/XUj98Rpz7Z22B4Wnbsb3MDAohY9amm
	yU58p7xnq7zqrs9HmYsXei9LEn5IhNZpbaX1TTbt/uUe2m7gLDxx39ZYBmzJHyGMT6k9/XBaa9V
	xc0TkjM1PYYibsLERaCmPGqgi8pDkmeWWFceYTj3YbSgToqCiAWzB5xDXgzOERV+Kt0FUPQLPEs
	C7mM1cMip5eYPPkABqC7M4xVZDCyKeqkyTrrqovKKGU9LNZju0GLFcV8jjvNUOygnAz4nnZ8VHo
	YZzLgiK4XAnhy6XZu0FrS79c4pSS+co31o2iyNtz92D3rRtFv9K7I+/UDE0Y+fY0qsTuCcxi0zC
	MLrqYTo43g7tn5Btaux7A4GRVP/jUTufv4c7otpDA1fPpA39aOOJNRHeudXDCZg40X5mIke8zK4
	AnESTRZ/IU+UGXeE/wUk9zPKBVjasbAZV1mKAk3jifkiRZVwPvUAmUwBynsQLZzZBuQbNFP85yh
	Q==
X-Received: by 2002:a05:6512:40ca:b0:59f:6923:1cbd with SMTP id 2adb3069b0e04-5a13cac11a2mr2777388e87.8.1773068518002;
        Mon, 09 Mar 2026 08:01:58 -0700 (PDT)
Received: from ribalda.c.googlers.com (27.69.88.34.bc.googleusercontent.com. [34.88.69.27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08cc0dsm2138003e87.80.2026.03.09.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:01:56 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: uvcvideo: Improvements for UVC metadata
Date: Mon, 09 Mar 2026 15:01:53 +0000
Message-Id: <20260309-uvc-metadata-dmabuf-v1-0-fc8b87bd29c5@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHgrmkC/x3MPQqAMAxA4atIZgNVUaxXEYfYRM3gD60WQby7x
 fEb3nsgiFcJ0GUPeIkadN8SijwDt9A2CyonQ2nKxlTG4hUdrnIS00nIK43XhKNtq9qKuJYZUnl
 4mfT+r/3wvh8e8f3AZQAAAA==
X-Change-ID: 20260309-uvc-metadata-dmabuf-b98359eec8dd
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yunke Cao <yunkec@google.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: DDFB723B396
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223682-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,chromium.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series introduces some improvements for UVC metadata:

- Allow bigger sizes of metadata.
- Refactor the code to avoid invalid pointer arithmetic.
- Add support for DMABUF

Cheers!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: uvcvideo: Enable VB2_DMABUF for metadata stream
      media: uvcvideo: uvc_queue_to_stream(): Support meta queues
      media: uvcvideo: Allow userspace to increase the meta buffersize

 drivers/media/usb/uvc/uvc_isight.c   |  3 ++-
 drivers/media/usb/uvc/uvc_metadata.c |  9 +++++++--
 drivers/media/usb/uvc/uvc_queue.c    | 18 ++++++++----------
 drivers/media/usb/uvc/uvcvideo.h     |  7 +++++--
 4 files changed, 22 insertions(+), 15 deletions(-)
---
base-commit: a7da7fb57f2a787412da1a62292a17fa00fbfbdf
change-id: 20260309-uvc-metadata-dmabuf-b98359eec8dd

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


