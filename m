Return-Path: <stable+bounces-152048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C333AD1F60
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7AE3AF87A
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1E25A625;
	Mon,  9 Jun 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTCSGJld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3878259C93;
	Mon,  9 Jun 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476688; cv=none; b=LfFg43+KyxmtI8swgytFUzCOy8p/GdggRzmQ5pBQEmAuBZzMevN3A2RUjFNvdZ0xOSTiIQMKrYZ4MGNt/ZRg6BPHbjUMNoIrlK7CDfOslv7dEIV+nGnTy/bpXl17been8kYp9qBAwesGtqOsWXLrY0xf208mye5JlKpzz6dscas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476688; c=relaxed/simple;
	bh=tFUG8HzIW//IN/0rdoNVAb1477sL9Oo8/9Wu4zkkaoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bg0Xv6uuoX3ZN9zzRMiKUZVOG5z0vbQpjclAlKg+NayAfH2+elitWmgxyOZ/1Zr/p7hNGJ0Qc0ElieP7F35S3S/P4vZi4wD1xbI2GUV2LuKK95x0Z6vTjNBdOFhpcPOEwe7lsz9TiBMIkwMhNtVCVNJ3ejJOzsdtEp++4MGObAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTCSGJld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC43C4CEF0;
	Mon,  9 Jun 2025 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476688;
	bh=tFUG8HzIW//IN/0rdoNVAb1477sL9Oo8/9Wu4zkkaoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTCSGJldput2Fbz9jvs1YFia3CgR8Lco5/ow8vmEqWU5yKJjCQmQXYM/QWODIB0qq
	 ++wRV/FmO0CXQD1Do8WNfQAxbB3SCkQPiQo6yDSOlVcTI+h96cOKm+OCB+9aSSN4N6
	 xdNIeDTqshzNsw5NPlNKm1fblZznAY379UpAIYnZ0toJIVod5/nZXYRFHseErT+Dly
	 31KG7b61mc+Y0RmeSA7bkArSP4/+aXOkJekD1rizjzPFmBC4jUTXOLHCe7kSK2kBiw
	 70D+eq54NBTwPOap3GMumprcWMu8/a7eBhH4Wjpsc+fh23toDUcodbuRAdV2P25Pzs
	 W+YdfGpSPQZcQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chenyuan Yang <chenyuan0y@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 25/35] misc: tps6594-pfsm: Add NULL pointer check in tps6594_pfsm_probe()
Date: Mon,  9 Jun 2025 09:43:41 -0400
Message-Id: <20250609134355.1341953-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134355.1341953-1-sashal@kernel.org>
References: <20250609134355.1341953-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit a99b598d836c9c6411110c70a2da134c78d96e67 ]

The returned value, pfsm->miscdev.name, from devm_kasprintf()
could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Link: https://lore.kernel.org/r/20250311010511.1028269-1-chenyuan0y@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Analysis

### 1. Bug Fix Nature
This commit fixes a clear NULL pointer dereference vulnerability. The
`devm_kasprintf()` function can return NULL on memory allocation
failure, and the code was not checking this return value before using
`pfsm->miscdev.name`. This would lead to a NULL pointer dereference when
`misc_register(&pfsm->miscdev)` is called at line 302.

### 2. Code Analysis
Looking at the specific changes in `drivers/misc/tps6594-pfsm.c`:

**Before the fix (lines 282-283):**
```c
pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
                                    tps->chip_id, tps->reg);
```

**After the fix (lines 282-286):**
```c
pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
                                    tps->chip_id, tps->reg);
+if (!pfsm->miscdev.name)
+    return -ENOMEM;
```

The fix adds essential NULL pointer checking that prevents potential
kernel crashes.

### 3. Comparison with Similar Commits
This fix follows the exact same pattern as the reference commits marked
as "Backport Status: YES":

- **Similar Commit #1 (ipmi)**: Same issue with `devm_kasprintf()` not
  being checked
- **Similar Commit #2 (mfd: tps6594)**: Same issue, even in the same
  TPS6594 subsystem
- **Similar Commit #4 (ice)**: Same issue, explicitly referenced in the
  commit message

All these similar commits were deemed suitable for backporting because
they fix the same fundamental issue.

### 4. Risk Assessment
- **Minimal risk**: The fix is a simple 2-line addition that only adds
  error checking
- **No side effects**: The change doesn't alter functionality, only
  prevents crashes
- **Contained scope**: Only affects the TPS6594 PFSM driver
  initialization path
- **No architectural changes**: Doesn't modify any interfaces or major
  logic

### 5. Stability Criteria Met
- ✅ **Important bug fix**: Prevents kernel NULL pointer dereference
  crashes
- ✅ **Minimal and contained**: Only 2 lines added for error checking
- ✅ **Low regression risk**: Cannot introduce new issues, only prevents
  crashes
- ✅ **Clear fix**: Addresses a well-defined problem with obvious
  solution

### 6. Driver Context
The TPS6594 PFSM driver was introduced in kernel v6.10, making it a
relatively recent addition. The driver handles power management for TI
PMIC devices, making reliability crucial for system stability.

### 7. Static Analysis Tool Finding
The commit message mentions this was found by static analysis, which
indicates it's a real potential issue that could manifest under memory
pressure conditions.

This commit clearly meets all the criteria for stable tree backporting:
it's a small, contained fix for an important potential crash bug with
minimal risk of regression.

 drivers/misc/tps6594-pfsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 0a24ce44cc37c..6db1c9d48f8fc 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -281,6 +281,9 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
 					    tps->chip_id, tps->reg);
+	if (!pfsm->miscdev.name)
+		return -ENOMEM;
+
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
 	pfsm->chip_id = tps->chip_id;
-- 
2.39.5


