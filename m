Return-Path: <stable+bounces-200137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B3CA7017
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 047773005C79
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E081B3148DC;
	Fri,  5 Dec 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fbiRk4tg"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC79314A7D;
	Fri,  5 Dec 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928362; cv=none; b=NCJ79EWXCxF6wtHegvO1sFJdF8LDOAWYfE3q+IRaE2/l+jSzMWY4N8LLaggjCzFhpom7mDIir4JOjD3EeDoIzq9nLfve92NIDVm+dp2xvWgROF88mCbTL8SoG5VhnVb36LRnLmjcE0ZV3Q0DjOKqwsaNEJhorJsqcScB59SmjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928362; c=relaxed/simple;
	bh=MwhXgW4rnOQ3KSc+GudAM5PShTGwJykoDUKEmfRikoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rTBjISOwUrPAHy63SOTlkmFl6JJdm5vt9N0db35etVyQnJrCIw7y6NDWr+COYfZ1XQaMkqjSwcu5HYNUtNJ6zWytj0O9CoJRbI/Ms1We2PdsebyLW3CwaqeEmWPMyXLTMD4bu/fg7bKoOpF62QLjocLHr+ja7FxelQWLqt2S35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fbiRk4tg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33843EAE;
	Fri,  5 Dec 2025 10:50:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1764928208;
	bh=MwhXgW4rnOQ3KSc+GudAM5PShTGwJykoDUKEmfRikoI=;
	h=From:Subject:Date:To:Cc:From;
	b=fbiRk4tg7s7BEQm0DNSKCqvfONzM9PYmpxTgwuUqk3nVU0a6Mw5JW/J+mF/3lS0bp
	 tEoHuNKYGONHG1MSvZ3UFqM9g8gUSCpa/u3xVDMpq4uppgxXYvoP+eZG/z0LOMGyjP
	 moCJLA2vjrejj4nuB7QX7z1vCpPaEzLiQaFJr+qU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/4] drm: Revert and fix enable/disable sequence
Date: Fri, 05 Dec 2025 11:51:47 +0200
Message-Id: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSrMmkC/x2MQQqAIBAAvyJ7bkFFPfSV6JC51h6yUohA/HvSc
 QZmKhTKTAVGUSHTw4XP1EENAtZ9SRshh86gpbZKS4shH1joxsgvekNBReucNB56cWXq+r9Nc2s
 fls7cZF0AAAA=
X-Change-ID: 20251205-drm-seq-fix-b4ed1f56604b
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Linus Walleij <linusw@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Vicente Bergas <vicencb@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=MwhXgW4rnOQ3KSc+GudAM5PShTGwJykoDUKEmfRikoI=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGkyq1Gj1d8xlj6diu63t7iZIaLIFc3fvXjAEHe/VLZfrvIfQ
 okCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJpMqtRAAoJEPo9qoy8lh717W0P+wRa
 1bq77t/4zLJJmCAjxcRV1DhoWfVPncOTXA2HSsEIMgPBHpUKZyan6fBYxHp6XkG0gNVZlwTrYhW
 pSyAvXsrnTNhW8q5otmzGyWpCw023NDpDDWbiGUgGg43yQml50nFn6Ij48jk2lXLvpfPWvcsvk6
 bpX+tDXMn0m+FLf1bYvhoJdJIyvq/0wvT5ZIgRfzsZZjWqjDR+WXbdtPV/hyleczIwGaJWqFNhV
 9op0yeeanXhucwBN2xqL73naXLUq9EBNDWtFE4LSmBBXBBLtqTx2K4b5Tsr8g3C9Ch5pf+Qqodm
 OVcabnpPmbZVlxRiBF11N0zi0chMynlCJDfFX0HjltHxOaqXW/LySuusslTdBU0FFpkdS9AwyEa
 lbdnRRJFwaU18kSgasLNEzSBV77gug1YhZ4kkVVTyblKCLlK0GojYFPsQEdPXoIjIXQcpurCr22
 Ln5os9CZuhApjyd3l241B6ZIvimL2MMi6eJE+MGkg6dRaD6GQdslRy1cbxJsY+nhPrku/DS5+58
 IwydYy0PKmXzLH4IcgDqAnmLcFnUstEvCq5lXmvbOPzAGKbIHyIIcxuy9vMmnG03hpyeD+7JY53
 EC2vrgEsPyrVDzXTj+rH5LCRxtu0UFsfuArS7xPBa95f4PCtPr5Cf4MCstwKNERRerTYeCdl8b1
 C77QO
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Changing the enable/disable sequence in commit c9b1150a68d9
("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable")
has caused regressions on multiple platforms: R-Car, MCDE, Rockchip.

This is an alternate series to Linus' series:

https://lore.kernel.org/all/20251202-mcde-drm-regression-thirdfix-v6-0-f1bffd4ec0fa%40kernel.org/

This series first reverts the original commit and reverts a fix for
mediatek which is no longer needed. It then exposes helper functions
from DRM core, and finally implements the new sequence only in the tidss
driver.

There is one more fix in upstream for the original commit, commit
5d91394f2361 ("drm/exynos: fimd: Guard display clock control with
runtime PM calls"), but I have not reverted that one as it looks like a
valid patch in its own.

I added Cc stable v6.17+ to all patches, but I didn't add Fixes tags, as
I wasn't sure what should they point to. But I could perhaps add Fixes:
<original commit> to all of these.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Linus Walleij (1):
      drm/atomic-helper: Export and namespace some functions

Tomi Valkeinen (3):
      Revert "drm/atomic-helper: Re-order bridge chain pre-enable and post-disable"
      Revert "drm/mediatek: dsi: Fix DSI host and panel bridge pre-enable order"
      drm/tidss: Fix enable/disable order

 drivers/gpu/drm/drm_atomic_helper.c | 122 ++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_dsi.c  |   6 -
 drivers/gpu/drm/tidss/tidss_kms.c   |  30 ++++-
 include/drm/drm_atomic_helper.h     |  22 ++++
 include/drm/drm_bridge.h            | 249 ++++++++++--------------------------
 5 files changed, 214 insertions(+), 215 deletions(-)
---
base-commit: 88e721ab978a86426aa08da520de77430fa7bb84
change-id: 20251205-drm-seq-fix-b4ed1f56604b

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


