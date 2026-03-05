Return-Path: <stable+bounces-223251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBCyBj6tqWn+CAEAu9opvQ
	(envelope-from <stable+bounces-223251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:20:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22F215554
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9E2E304B832
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859A3CE4A3;
	Thu,  5 Mar 2026 16:17:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 16.mo561.mail-out.ovh.net (16.mo561.mail-out.ovh.net [188.165.56.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870B3CE4BF
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727428; cv=none; b=Ez5NvmCJktrw9UH2mhN4GquPP1kj6zx7fsvvy/fJTUJNI5ZQXPdmkW3I/gqMz1xD4Df7mxlpAMAeSdkIAMtCJ6Vgiqs7RlYpxY2JxQOd8g5WFm5XYwfNa39U3E6iej4CEtvGbD/PbIf+z0+2uz12y1TmefWNh8ZKVohiK6gE/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727428; c=relaxed/simple;
	bh=tTjY5bp0iTm2WCvHOqhfSqQFJeTDlje+fkP7UD/PYN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZjBeuZpesqFbnyjZoPaA7JdyUDyDCUeUu7nei+8TwZuNJQJAypWe2OwIoL8dj9efi7YCM0HYhjHssDv8B/LJ4MdFANO8d1eduI4o/jWZvkUKNG84SmjqFobUIWkZzvSopI26+mLuTff2YC7rv8VUIG5/LgMPRcy/sIJCHuVjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=188.165.56.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.0.202])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4fRTb50sbhz5x0w
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 12:37:53 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-wdjj2 (unknown [10.110.118.54])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5D555C284A;
	Thu,  5 Mar 2026 12:37:52 +0000 (UTC)
Received: from m-works.net ([37.59.142.109])
	by ghost-submission-7d8d68f679-wdjj2 with ESMTPSA
	id 6qY8OR95qWl+bhsArAFjuQ
	(envelope-from <maciej.andrzejewski@m-works.net>); Thu, 05 Mar 2026 12:37:52 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S0032fe0d132-1f76-42ce-b129-39610cbfe1d1,
                    E291CFBA5258997C937E8CA829FF8FA8CC2CB86B) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:85.232.250.78
Date: Thu, 5 Mar 2026 13:37:51 +0100
From: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
To: Peter Korsgaard <jacmet@sunsite.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	maciej.andrzejewski@m-works.net
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Subject: [PATCH] serial: uartlite: fix PM runtime usage count underflow on
 probe
Message-ID: <20260305123746.4152800-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0
x-ovh-tracer-id: 8728257556967727907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE+BBN4ki3MZI6UJwwXPNXr7zQhdIUJFJhmPVn4bY1kqxTrnVqh3yPzi/yOrNJawXuQhB39ItU8158PVFKGLX2ZhRKSfN1qHtYtSL1ksSWLb4GHbJD/ofLRHtslEZCkIxKHauApY/5ia/qmyIFMzAo16R5zGVCFUA6c7gcqjo4kk9t+mawt/OgBmYCXpmV+EPnwzx2tiD8sVNkR7siUi9QHaKWeX6kIYA+zJQZBZZDa9l0NRJ+HxyoIDXNTT1HnDGg8NALUmMaDi0bezRsnyqaNwl8x0FicpK/DLGmZPgq5BUr0LoF1MynX2wZcm2G1gFUwvExcL/Lvelo9i/nfwmuaLE3fI89d5k/W4Uj5TqIDfmrGP00GbuBIZM2hTjid+oe+tPW6lx7Lgk8OD6Zqmaxs3iBHikwdGx9vxmuQ/ukTndXByw/N9M9j2SvdKSjtb77+L/VqqH6SETfsHxDrkBlL6r59vFWesFId7gb+1Fw/G9nqVQXP/lyZ6MegwCMCOyV/pNJ9pffd8cJuZfs+338ZtgGURhU3+VriMpM/Ee2zohvDi4UEnKzLwuxCmJ9JHuUXq9d+pQKvvSUMyH+AEkVYp4LkjGA68HF1D28zHDcnZyuLJHuog9Wa8Wa7kSz0HrhBgl5hdhv/yVJFd2TyC6ZxazYlOxMkGJf8a+D7JL+V5g
X-Rspamd-Queue-Id: 7F22F215554
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[m-works.net];
	TAGGED_FROM(0.00)[bounces-223251-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.andrzejewski@m-works.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

ulite_probe() calls pm_runtime_put_autosuspend() at the end of probe
without holding a corresponding PM runtime reference for non-console
ports.

During ulite_assign(), uart_add_one_port() triggers uart_configure_port()
which calls ulite_pm() via uart_change_pm(). For non-console ports, the
UART core performs a balanced get/put cycle:

  uart_change_pm(ON)  -> ulite_pm() -> pm_runtime_get_sync()        +1
  uart_change_pm(OFF) -> ulite_pm() -> pm_runtime_put_autosuspend() -1

This leaves no spare reference for the pm_runtime_put_autosuspend() at
the end of probe. The PM runtime core prevents the count from actually
going below zero, and instead triggers a
"Runtime PM usage count underflow!" warning.

For console ports the bug is masked: the UART core skips the
uart_change_pm(OFF) call, so the UART core's unbalanced get happens to
pair with probe's trailing put.

Add pm_runtime_get_noresume() before pm_runtime_enable() to take an
explicit probe-owned reference that the trailing
pm_runtime_put_autosuspend() can release. This ensures a correct usage
count regardless of whether the port is a console.

Fixes: 5bbe10a6942d ("tty: serial: uartlite: Add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
---
 drivers/tty/serial/uartlite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 39c1fd1ff9ce..6240c3d4dfd7 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -878,6 +878,7 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
-- 
2.43.0

