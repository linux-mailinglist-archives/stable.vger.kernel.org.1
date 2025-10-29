Return-Path: <stable+bounces-191602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E0C1A649
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F24189EBB8
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6B033F387;
	Wed, 29 Oct 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vYWRpJ+4"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A80354715;
	Wed, 29 Oct 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740736; cv=none; b=gO+ngXOoEqNdmInErChQXfRQHQS64j5jNtk6zy7cZrY7EVpOVsjT4QlS7x+UjOe3j9IeFdjkrIqIAem6yODMDRwhvdROOMZkKkivz55ZAO905BdA6FPsJA4LT1GsKPepwKg2pB7PpSZkVAxqYDXLBRZ9ydy9ovg66oq4TjG+vXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740736; c=relaxed/simple;
	bh=/+D8e3w7keuyHVljmO9v+nZYyyvmPGewctw3TwK4ofE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBvq82L5Lf1bLQDzCCxpJesf5gdr6l05GKqIlro1xVgm4EWlINwZCM9lvUR5JuKZWJmyd/nUYfQ8L2UZ2ZMDleMyTp/EWVExNaY+hgkZbdMjnxKTLM5aTiCZMa9tOymEZWcqBwMuJAgrqmZl0cr/NrhSqxdARXMpphce6cnVLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=vYWRpJ+4; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2C11280DF4;
	Wed, 29 Oct 2025 15:25:29 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:2::1:3d])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id PPdUA30G0Cg0-ZuFDoAIf;
	Wed, 29 Oct 2025 15:25:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1761740728;
	bh=1fQKQ83XfcLNxwtPZTJ+LlUequJp8085Dk/31B/lnGQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vYWRpJ+4vy8S0VLwqkSFBm4h+wJ1vAGn/Di0QtEcBvEv70EOyOQzbHKgp1PcRBxxz
	 9HtV7PZ+M41O5m+HJDo/5J9PFcPPYEMXnPAQmYgWRA+aCqnSdb6P3PvhWcOj6WB50S
	 HePfX8FaWzIvxI6jH4aj+hRRJ0Yq/dtK+3UAqQGw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] comedi: pcl726: Prevent invalid irq number
Date: Wed, 29 Oct 2025 15:25:25 +0300
Message-ID: <20251029122525.2078-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

commit 96cb948408b3adb69df7e451ba7da9d21f814d00 upstream.

The reproducer passed in an irq number(0x80008000) that was too large,
which triggered the oob.

Added an interrupt number check to prevent users from passing in an irq
number that was too large.

If `it->options[1]` is 31, then `1 << it->options[1]` is still invalid
because it shifts a 1-bit into the sign bit (which is UB in C).
Possible solutions include reducing the upper bound on the
`it->options[1]` value to 30 or lower, or using `1U << it->options[1]`.

The old code would just not attempt to request the IRQ if the
`options[1]` value were invalid.  And it would still configure the
device without interrupts even if the call to `request_irq` returned an
error.  So it would be better to combine this test with the test below.

Fixes: fff46207245c ("staging: comedi: pcl726: enable the interrupt support code")
Cc: stable <stable@kernel.org> # 5.13+
Reported-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5cd373521edd68bebcb3
Tested-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/tencent_3C66983CC1369E962436264A50759176BF09@qq.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Andrey Troshin: backport fix from drivers/comedi/drivers/pcl726.c to drivers/staging/comedi/drivers/pcl726.c]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2025-39685
Link: https://nvd.nist.gov/vuln/detail/CVE-2025-39685
---
 drivers/staging/comedi/drivers/pcl726.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/pcl726.c b/drivers/staging/comedi/drivers/pcl726.c
index 64eb649c9813..f26d7f07d749 100644
--- a/drivers/staging/comedi/drivers/pcl726.c
+++ b/drivers/staging/comedi/drivers/pcl726.c
@@ -327,7 +327,8 @@ static int pcl726_attach(struct comedi_device *dev,
 	 * Hook up the external trigger source interrupt only if the
 	 * user config option is valid and the board supports interrupts.
 	 */
-	if (it->options[1] && (board->irq_mask & (1 << it->options[1]))) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (board->irq_mask & (1U << it->options[1]))) {
 		ret = request_irq(it->options[1], pcl726_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
-- 
2.34.1


