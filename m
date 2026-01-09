Return-Path: <stable+bounces-207567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F1D0A277
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3B17300B6B8
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10135CB95;
	Fri,  9 Jan 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRD8QL3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F335CB96;
	Fri,  9 Jan 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962422; cv=none; b=u7p98bFzGbX3xrCpSMIFNSm5FV8vXnX//BoZTptxelkDAvfzZYt8gTGnDUA0DaxEFWQFzQguWA/InDjkne1qbjgLYwCATCiU+Y3AK6hEr+2E0Ia2uuP5n/4WEczt+zM8BceDJ/HJatK2DeafIcl7dnNxsw7MgY5DNs57ZJHVfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962422; c=relaxed/simple;
	bh=EQ+/YBbhvX0PhFa9ycBoo52H5GVeARvzPO/Fiy1Y0jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwFA9iJ6nZmqxPm7J7udjAVqSjvcIyoTNU7Uj8pVY65/4tAmMIalB81OcLhvT1MQ6cM2naOFJurcvgvcijfVwK1P/g9J5oftbVTqQILd7wrdVlI0NQ61GhyhQ8L9rv2LfObSWFarOw3dw12LK9Uc9OHlEZWO5zVpQD7oSw7ls6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRD8QL3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E033EC4CEF1;
	Fri,  9 Jan 2026 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962422;
	bh=EQ+/YBbhvX0PhFa9ycBoo52H5GVeARvzPO/Fiy1Y0jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRD8QL3i/7VX57QQNWeCWJ0ghTy4DM7wrM9gBkAVgPTAVZTjz+I96Q4iqpvBQ9m0a
	 sI+5N0m74PHikTMw1WZSPSRVL5ixQyO0DIqGBiJwHtLeim+fiFW5pgujPkpKqStZSn
	 HQdCmN6d+JDQteJZaypvw3N9O/Buwd0kc3GUbtuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	fuqiang wang <fuqiang.wng@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1 360/634] KVM: x86: Explicitly set new periodic hrtimer expiration in apic_timer_fn()
Date: Fri,  9 Jan 2026 12:40:38 +0100
Message-ID: <20260109112131.069462752@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: fuqiang wang <fuqiang.wng@gmail.com>

commit 9633f180ce994ab293ce4924a9b7aaf4673aa114 upstream.

When restarting an hrtimer to emulate a the guest's APIC timer in periodic
mode, explicitly set the expiration using the target expiration computed
by advance_periodic_target_expiration() instead of adding the period to
the existing timer.  This will allow making adjustments to the expiration,
e.g. to deal with expirations far in the past, without having to implement
the same logic in both advance_periodic_target_expiration() and
apic_timer_fn().

Cc: stable@vger.kernel.org
Signed-off-by: fuqiang wang <fuqiang.wng@gmail.com>
[sean: split to separate patch, write changelog]
Link: https://patch.msgid.link/20251113205114.1647493-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2639,7 +2639,7 @@ static enum hrtimer_restart apic_timer_f
 
 	if (lapic_is_periodic(apic) && !WARN_ON_ONCE(!apic->lapic_timer.period)) {
 		advance_periodic_target_expiration(apic);
-		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
+		hrtimer_set_expires(&ktimer->timer, ktimer->target_expiration);
 		return HRTIMER_RESTART;
 	} else
 		return HRTIMER_NORESTART;



