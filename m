Return-Path: <stable+bounces-238615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBYxJcAO5GnLPwEAu9opvQ
	(envelope-from <stable+bounces-238615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 01:07:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1F422905
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 01:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44593013D50
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD537E2EA;
	Sat, 18 Apr 2026 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYbsiVpP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990D37DEA7
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776553659; cv=none; b=RZRw4Mw9hzv0F9DbXH8HnMkeiJwEZYXO0OLsXvEl+imLIjiW56DI0Rcvgslu1HHXq3UjxXm/nZFdHobSM/LPiRDQEmb+h7vlLP8MkIASCpt808H3wOYTqx7V8Lu8/dWygU6RaRTHFmqByY07EHyoUZAxmRIybJhdQE1Gne0TJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776553659; c=relaxed/simple;
	bh=AnpyfMK12VlXaL6i2J+RnCaY2GlCQozt4w8fsBHIrUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfAFLWIJL1gmGJxdU4VpAtq6I8WCpmnaC2tWFUDm25Jci+0KZfuFc1wN77XshRIWpXkw2evl1AvYej5HyTX19cdvdBUWEeSGTQdp9H7u5lqMgBXHup3KupPkwc1BSdkvnE20mrG+XBy8RwRStzOcsJXKI4aueO2edEPBPmQ2b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYbsiVpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A844CC19424;
	Sat, 18 Apr 2026 23:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776553658;
	bh=AnpyfMK12VlXaL6i2J+RnCaY2GlCQozt4w8fsBHIrUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYbsiVpPxVIMyJGkI35RmYa+967TMTKZQMcuIylm0hVd9BvYhypCCUig053KP7bKQ
	 KV25tVYP7oUJf86RbQEvreWL52M5PSlMR4T1uQZTqJzEXT70AjTZnD9trKbqBxhYfT
	 CkxoXSOi3djJRy7x8eMocQmsD01n5k88Ynxe4L34c0kqd5MTIsY6ufxfd5sNIhqjQC
	 0LAQOg8ywkNPhynO6fRq9ADkMACD1EOTuxNTZI4R63GM8HDTRq4OFanAouE3BhGGIL
	 EmBlo7uF1hCgjXtmsIpNxa5i/dWkYgPuxR4t+zhUk5I0ST+5m6UpC48Gartq5o+Twr
	 +mQSVndOnZcNQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	kernelci-results@groups.io
Subject: [PATCH 5.10] ACPI: property: Constify stubs for CONFIG_ACPI=n case
Date: Sat, 18 Apr 2026 16:07:04 -0700
Message-ID: <20260418230704.4178547-1-nathan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <177650634337.369.12638743148475442890@062ea10430ee>
References: <177650634337.369.12638743148475442890@062ea10430ee>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238615-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: ECA1F422905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 5c1a72a0fbe1b02c3ce0537f85f92ea935e0beec upstream.

There is a few stubs that left untouched during constification of
the fwnode related APIs. Constify three more stubs here.

Fixes: 8b9d6802583a ("ACPI: Constify acpi_bus helper functions, switch to macros")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This resolves compiler warning/errors seen in 5.10.253.

GCC:

  drivers/base/property.c: In function 'device_dma_supported':
  drivers/base/property.c:896:55: warning: passing argument 1 of 'to_acpi_device_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    896 |         return acpi_dma_supported(to_acpi_device_node(fwnode));
        |                                                       ^~~~~~
  In file included from drivers/base/property.c:10:
  include/linux/acpi.h:756:77: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
    756 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
        |                                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
  drivers/base/property.c: In function 'device_get_dma_attr':
  drivers/base/property.c:911:62: warning: passing argument 1 of 'to_acpi_device_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    911 |                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
        |                                                              ^~~~~~
  include/linux/acpi.h:756:77: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
    756 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
        |                                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~

Clang:

  drivers/base/property.c:896:48: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    896 |         return acpi_dma_supported(to_acpi_device_node(fwnode));
        |                                                       ^~~~~~
  include/linux/acpi.h:756:77: note: passing argument to parameter 'fwnode' here
    756 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
        |                                                                             ^
  drivers/base/property.c:911:48: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    911 |                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
        |                                                              ^~~~~~
  include/linux/acpi.h:756:77: note: passing argument to parameter 'fwnode' here
    756 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
        |                                                                             ^
  2 errors generated.

  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/24605516423
---
 include/linux/acpi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9c184dbceba4..c5b51d8dcbe1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -753,7 +753,7 @@ static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
 	return false;
 }
 
-static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
+static inline struct acpi_device *to_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
@@ -763,12 +763,12 @@ static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
 	return false;
 }
 
-static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
+static inline struct acpi_data_node *to_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
 
-static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
 					const char *name)
 {
 	return false;

base-commit: 49e5d20074c20b20773c6dc0f8dce0635591093b
-- 
2.53.0


