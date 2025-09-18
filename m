Return-Path: <stable+bounces-166317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D4B198F4
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BD61897E2F
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8C1DE3BB;
	Mon,  4 Aug 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thr/m+de"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AF1FDD;
	Mon,  4 Aug 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267933; cv=none; b=UpAnkx+6NzGDHdn+9tef4Qa0XbAUg/w2XBsvm7S3wDMs/xWOSMnsmalmdh3HWSSDI7zsdD1z8WgfjUwRswcG5n+KJVYBuzFp3oHGJPbgHt0EMQaz74qetuM9g58bOmp0ur/sawPFUEa7UjOaQSqJd2OyydH1faJp380PSpSVzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267933; c=relaxed/simple;
	bh=3ZwGiG6NvVobGLhe/on8fmD0OZ7W8X5aLTxzV7VD7+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YYdCORvrCDPNPQTi9SCC7yuEdQmYnq3tOL16emi1T38jShWDtrKYaLwVj2ChSlrJuYVchivvTxPXqrdDlGEBGQRtc8/o3T049EXOaOzGgfyIeiRyxYtsxqdjwFXGSaMNxxzjafU/cTNZMG4nkKeJnEDavOUtUbUuCjTXjMgTzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thr/m+de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E040DC4CEEB;
	Mon,  4 Aug 2025 00:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267933;
	bh=3ZwGiG6NvVobGLhe/on8fmD0OZ7W8X5aLTxzV7VD7+s=;
	h=From:To:Cc:Subject:Date:From;
	b=thr/m+deAyQKGvxbUJ+YVCZoXqI3rQqUXM0Ayn4+8VL4d1ECcsmPUXfY3/t6J7GN/
	 /cMM6Y30o1OsiGun4qxL3tBUXfn4k5e5IaGs6+vi890wneMJEvFlDLlRTO89Qfy62i
	 FA2gq2F66OSTVGjeEilrIBZtv9jh4rNCuzZZW0KgJWRtsJC1GG+GQUcdCM3WLJB4kC
	 8AQglkQ2f2JH7oqzkSK7OvGtKYJD7l5KZxqJ9n6QzbxpfAS4z3er+sG+jHZ6CJVbtV
	 Q5uV2eHYj7Xge9PRLGNNDijW9eqU4vtjYNqyUqb7Uik9irgDlVH80Kyui+FAF/LRbc
	 lmnPy2TkMSYRQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/44] usb: xhci: print xhci->xhc_state when queue_command failed
Date: Sun,  3 Aug 2025 20:38:06 -0400
Message-Id: <20250804003849.3627024-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 7919407eca2ef562fa6c98c41cfdf6f6cdd69d92 ]

When encounters some errors like these:
xhci_hcd 0000:4a:00.2: xHCI dying or halted, can't queue_command
xhci_hcd 0000:4a:00.2: FIXME: allocate a command ring segment
usb usb5-port6: couldn't allocate usb_device

It's hard to know whether xhc_state is dying or halted. So it's better
to print xhc_state's value which can help locate the resaon of the bug.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250725060117.1773770-1-suhui@nfschina.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit is suitable for backporting to stable kernel trees for the
following reasons:

1. **Enhanced Debugging for Real-World Issues**: The commit improves
   debugging of USB xHCI host controller failures by printing the actual
   `xhc_state` value when `queue_command` fails. The commit message
   shows real error messages users encounter ("xHCI dying or halted,
   can't queue_command"), demonstrating this is a real-world debugging
   problem.

2. **Minimal and Safe Change**: The change is extremely small and safe -
   it only modifies a debug print statement from:
  ```c
  xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
  ```
  to:
  ```c
  xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state:
  0x%x\n", xhci->xhc_state);
  ```

3. **No Functional Changes**: This is a pure diagnostic improvement. It
   doesn't change any logic, control flow, or data structures. It only
   adds the state value (0x%x format) to an existing debug message.

4. **Important for Troubleshooting**: The xHCI driver is critical for
   USB functionality, and when it fails with "dying or halted" states,
   knowing the exact state helps diagnose whether:
   - `XHCI_STATE_DYING` (0x1) - controller is dying
   - `XHCI_STATE_HALTED` (0x2) - controller is halted
   - Both states (0x3) - controller has both flags set

   This distinction is valuable for debugging hardware issues, driver
bugs, or system problems.

5. **Zero Risk of Regression**: Adding a parameter to a debug print
   statement has no risk of introducing regressions. The worst case is
   the debug message prints the state value.

6. **Follows Stable Rules**: This meets stable kernel criteria as it:
   - Fixes a real debugging limitation
   - Is obviously correct
   - Has been tested (signed-off and accepted by Greg KH)
   - Is small (single line change)
   - Doesn't add new features, just improves existing diagnostics

The commit helps system administrators and developers diagnose USB
issues more effectively by providing the actual state value rather than
just saying "dying or halted", making it a valuable debugging
enhancement for stable kernels.

 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index cd94b0a4e021..626f02605192 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -4486,7 +4486,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 
 	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
 		(xhci->xhc_state & XHCI_STATE_HALTED)) {
-		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
+		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: 0x%x\n",
+			 xhci->xhc_state);
 		return -ESHUTDOWN;
 	}
 
-- 
2.39.5


