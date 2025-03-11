Return-Path: <stable+bounces-123139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F47A5B697
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 03:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EBA3AA999
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9981E32D9;
	Tue, 11 Mar 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba0lMRoX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148C15820C;
	Tue, 11 Mar 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659566; cv=none; b=Zk0vJpaMK9Oq14zdCtELF9KnaqwunXtPwqC6FfxOudFSFZ2vt+hwG9dTEaUa8XBOHnw3r4tlQTpT198rYCbhM7HRr8cOxQL8OsKKxpfP4S5Nra0AjYqYlEb47ss9aL4iDTjssJnI2OhLSfOSsRAQx13CLQ+kMb4QzKugx08ucws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659566; c=relaxed/simple;
	bh=mfAmdbFQbLlMZDckT+cuqEi3rf2Re5oZ+lu2lZ/dX1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PWhLSn2eQqu8BTIiriw2kUwcMVxO8TO9ex+oJwWCl78B7ljP3illJvHBq+2YwCRoZf6pe+ggzETMLkK/kCG0AsjGUqDbZGtXJK82WPFyy8Yjk5EKTlY7QzxN/A4AalRMue5S1Iu0u27n3Zz92psPq986Cpi7koYkwT8dJuO50DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba0lMRoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCC8DC4CEE5;
	Tue, 11 Mar 2025 02:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741659565;
	bh=mfAmdbFQbLlMZDckT+cuqEi3rf2Re5oZ+lu2lZ/dX1Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ba0lMRoXy/XRrv3mYJAKFSr3WPmRFH+7UUaL7GFJYFSfW9bWCxbbAAii4MBnE6CPe
	 G8SuKgd+ObzFc6TWDRbQrG2NW+3eQlFdp8dXTvw7KNEipn2ooVhKj1CPhzD1Tq7ri0
	 BDN6erjXK3ZfpDTeZUusbFL9QA+QzbOvsZw8WRiI/Lk6IR9TtuzTodgPa0Ho+FYV8s
	 hW7l51R14P+h37qy15TH+nkXcCQST3piLUuJ9R7zELbnBVgdWvi/qVTRASgqWPzvLc
	 xJVYA08Erp7/WJUnrwgR7Q//s7kwi7PnJuBdF0kmTv1VMxmn68aKxm6ThBrGgKfRsH
	 eNwpvMh1yMjEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17FBC282DE;
	Tue, 11 Mar 2025 02:19:25 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Mon, 10 Mar 2025 19:19:07 -0700
Subject: [PATCH] usb: typec: tcpm: fix state transition for
 SNK_WAIT_CAPABILITIES state in run_state_machine()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-fix-snk-wait-timeout-v6-14-rc6-v1-1-5db14475798f@google.com>
X-B4-Tracking: v=1; b=H4sIAJqdz2cC/x2NQQqDMBQFryJ/7YPEWiW9irgw8Vs/pbEkqQri3
 Q0uZzEzB0UOwpFexUGBV4my+Ay6LMjNg38zZMxMlaqe6qEVJtkR/QfbIAlJvrz8E9YGukZwDVp
 bj2ayxjpjKEd+gbNxD7r+PC8ebybscAAAAA==
X-Change-ID: 20250310-fix-snk-wait-timeout-v6-14-rc6-7b4d9fb9bc99
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741659565; l=1869;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=XWKs46l6MPTHMIBPMpAx7vxNIqzh3Rjw4va51+i3hu0=;
 b=mOi/HQ11Z/dzJ5PxxlT67S+U9on/YeTBQANmHH5IF/SogEd0hxlPmReJW7KBH8mte5yaCXODy
 Z0P5YiKv/lqDw0c7ak5BFfx5wnO/acB2v7BH7AEhFAbAbhHPwrtfGqe
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

A subtle error got introduced while manually fixing merge conflict in
tcpm.c for commit 85c4efbe6088 ("Merge v6.12-rc6 into usb-next"). As a
result of this error, the next state is unconditionally set to
SNK_WAIT_CAPABILITIES_TIMEOUT while handling SNK_WAIT_CAPABILITIES state
in run_state_machine(...).

Fix this by setting new state of TCPM state machine to `upcoming_state`
(that is set to different values based on conditions).

Cc: stable@vger.kernel.org
Fixes: 85c4efbe60888 ("Merge v6.12-rc6 into usb-next")
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 47be450d2be352698e9dee2e283664cd4db8081b..758933d4ac9e4e55d45940b068f3c416e7e51ee8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5117,16 +5117,16 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		if (port->vbus_never_low) {
 			port->vbus_never_low = false;
-			tcpm_set_state(port, SNK_SOFT_RESET,
-				       port->timings.sink_wait_cap_time);
+			upcoming_state = SNK_SOFT_RESET;
 		} else {
 			if (!port->self_powered)
 				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
 			else
 				upcoming_state = hard_reset_state(port);
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
-				       port->timings.sink_wait_cap_time);
 		}
+
+		tcpm_set_state(port, upcoming_state,
+			       port->timings.sink_wait_cap_time);
 		break;
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:
 		/*

---
base-commit: 5c8c229261f14159b54b9a32f12e5fa89d88b905
change-id: 20250310-fix-snk-wait-timeout-v6-14-rc6-7b4d9fb9bc99

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



