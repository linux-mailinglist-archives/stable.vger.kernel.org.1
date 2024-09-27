Return-Path: <stable+bounces-78026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6E9884B7
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0715B282FE2
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B018C012;
	Fri, 27 Sep 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vn+WzaeF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325518C034;
	Fri, 27 Sep 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440218; cv=none; b=TOYFzeZYafO9/oZLPZyRsaMtC1CTKqrSGAf1r+8p4nR2vLNDQFA4F8RdraIOaQcFcsyzSWjiGRqf53ug/VQ34mlzBbGAAfeE/HHv//90sJ0fKsVPGwRWWtLWZzByxrXk1kMxHM89+0jm7bkkJdlGKLU9KZpz+11N54DytB/paRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440218; c=relaxed/simple;
	bh=y5BFmTeSe9/AM1d26bEYjjDSnWu3iWDJ6JiKpyZJQJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HulINnWhlHDlPoeRpsatP/DDOA0LcRAKrvWtyvZnVhFOV+RvVTOr+wK8OIKIfURsNYpwVguW2f9piEBz3hK0DUgvpXkL7YfGYMQQvLPFDYU0mOnj+7LWDDE8VqaQrilUuC9pCHdM49z+e7Ptj7Pbgx5G9u3yWiE1Z856u08PvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vn+WzaeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D05C4CEC4;
	Fri, 27 Sep 2024 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440217;
	bh=y5BFmTeSe9/AM1d26bEYjjDSnWu3iWDJ6JiKpyZJQJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vn+WzaeFs7138A7qNHUwp1+wOynfbXy7G7yJwaKBs8Am1FWzY2+Jd1jOOiPd/vFzE
	 kndiRsoKzN5in+ENfNJzzjevJ5aYklFwrfnQZmfc0O2MUoONoHSVye0x+ESXdwXGaq
	 WHYI+O3goV2sXBL2lXJqYdKOR7iBVWw/r0P69rPA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Larabel <michael@michaellarabel.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 05/12] powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs
Date: Fri, 27 Sep 2024 14:24:08 +0200
Message-ID: <20240927121715.461646108@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

[ Upstream commit 26096aed255fbac9501718174dbb24c935d8854e ]

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_logical_die_id() macros, no longer returns package id, instead it
returns the CCD (Core Complex Die) id. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

For more historical context, please refer to commit 32fb480e0a2c
("powercap/intel_rapl: Support multi-die/package"), which initially changed
the RAPL scope from package to die for all systems, as Intel systems
with Die enumeration have RAPL scope as die, and those without die
enumeration are not affected. So, all systems(Intel, AMD, Hygon), worked
correctly with topology_logical_die_id() until recently, but this changed
after the "0x80000026 leaf" commit mentioned above.

Future multi-die Intel systems will have package scope RAPL counters,
but they will be using TPMI RAPL interface, which is not affected by
this change.

Replacing topology_logical_die_id() with topology_physical_package_id()
conditionally only for AMD and Hygon fixes the energy-pkg event.

On an AMD 2 socket 8 CCD Zen4 server:

Before:

linux$ ls /sys/class/powercap/
intel-rapl      intel-rapl:4    intel-rapl:8:0  intel-rapl:d
intel-rapl:0    intel-rapl:4:0  intel-rapl:9    intel-rapl:d:0
intel-rapl:0:0  intel-rapl:5    intel-rapl:9:0  intel-rapl:e
intel-rapl:1    intel-rapl:5:0  intel-rapl:a    intel-rapl:e:0
intel-rapl:1:0  intel-rapl:6    intel-rapl:a:0  intel-rapl:f
intel-rapl:2    intel-rapl:6:0  intel-rapl:b    intel-rapl:f:0
intel-rapl:2:0  intel-rapl:7    intel-rapl:b:0
intel-rapl:3    intel-rapl:7:0  intel-rapl:c
intel-rapl:3:0  intel-rapl:8    intel-rapl:c:0

After:

linux$ ls /sys/class/powercap/
intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0

Only one sysfs entry per-event per-package is created after this change.

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Reported-by: Michael Larabel <michael@michaellarabel.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Link: https://patch.msgid.link/20240730044917.4680-3-Dhananjay.Ugwekar@amd.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 34 ++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8b7a5a31e8c17..5a6d05bf847ce 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2129,6 +2129,21 @@ void rapl_remove_package(struct rapl_package *rp)
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms use per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1 CLX-AP platform has per-DIE package energy counter
+ *	2.2 Other platforms that uses MSR RAPL are single die systems so the
+ *          package energy counter can be considered as per-PKG/per-DIE,
+ *          here it is considered as per-DIE.
+ *	2.3 New platforms that use TPMI RAPL doesn't care about the
+ *	    scope because they are not MSR/CPU based.
+ */
+#define rapl_msrs_are_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 /* caller to ensure CPU hotplug lock is held */
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
 							 bool id_is_cpu)
@@ -2136,8 +2151,14 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 	struct rapl_package *rp;
 	int uid;
 
-	if (id_is_cpu)
-		uid = topology_logical_die_id(id);
+	if (id_is_cpu) {
+		uid = rapl_msrs_are_pkg_scope() ?
+		      topology_physical_package_id(id) : topology_logical_die_id(id);
+		if (uid < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return ERR_PTR(-EINVAL);
+		}
+	}
 	else
 		uid = id;
 
@@ -2169,9 +2190,14 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 		return ERR_PTR(-ENOMEM);
 
 	if (id_is_cpu) {
-		rp->id = topology_logical_die_id(id);
+		rp->id = rapl_msrs_are_pkg_scope() ?
+			 topology_physical_package_id(id) : topology_logical_die_id(id);
+		if ((int)(rp->id) < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return ERR_PTR(-EINVAL);
+		}
 		rp->lead_cpu = id;
-		if (topology_max_dies_per_package() > 1)
+		if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
-- 
2.43.0




