Return-Path: <stable+bounces-160928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA331AFD29C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6B31884BD5
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737432E54DC;
	Tue,  8 Jul 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URws/xFO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308822DD5EF;
	Tue,  8 Jul 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993100; cv=none; b=pDHVcV9NB+aa2wmx9ebsce63bGj8mI5YYzfHXL6fFgG41D9T0u3y25+I+ZnHXlyhZ3GuKKaUPZPJASuwUpDcVi4boXb0WOjhDD7GZUf8idhKeXLSlR0G98kaO0NDpxMNYLsLQA27e0kQBkMhIUdxUelx5dvy2ECSoBbu3/6Il1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993100; c=relaxed/simple;
	bh=AWbGdAU5K9JJR5IbEXjSR5TIkTvb01qrxuIju1dNenM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzvapbRHcP1i5nw2xizIq3CqqhkNp0j+MesdtRbo3tX8ztpOjmLzU7pD4JLevoqhaNGhu3/FfuQLEZ0xubdUiqwO2bm46jBRm1X0XQRlrQ/n/2XoCGbpOs878VU3ykFAqYSNmzlHm76gzSMFV4z2lDWI+mfckaTh2SI4FnjbsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URws/xFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95E0C4CEF0;
	Tue,  8 Jul 2025 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993100;
	bh=AWbGdAU5K9JJR5IbEXjSR5TIkTvb01qrxuIju1dNenM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URws/xFOjONZ9OV/UpTxFjtiZ9mU1CsfFX76agPzY7OOc/vH6VLK3dAsk1vIPx2tA
	 B+bxgNcQxbzF9cXZp0foz1+79Ty9gxAOhTpMsIaqqixedQLGCSdSbj/r31xGGOdPLb
	 H04ZGSJj8xeCouNDmquirUFs615YOpJJUhdJToMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Williams <peter@newton.cx>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 187/232] ACPICA: Refuse to evaluate a method if arguments are missing
Date: Tue,  8 Jul 2025 18:23:03 +0200
Message-ID: <20250708162246.327162883@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 6fcab2791543924d438e7fa49276d0998b0a069f ]

As reported in [1], a platform firmware update that increased the number
of method parameters and forgot to update a least one of its callers,
caused ACPICA to crash due to use-after-free.

Since this a result of a clear AML issue that arguably cannot be fixed
up by the interpreter (it cannot produce missing data out of thin air),
address it by making ACPICA refuse to evaluate a method if the caller
attempts to pass fewer arguments than expected to it.

Closes: https://github.com/acpica/acpica/issues/1027 [1]
Reported-by: Peter Williams <peter@newton.cx>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Tested-by: Hans de Goede <hansg@kernel.org> # Dell XPS 9640 with BIOS 1.12.0
Link: https://patch.msgid.link/5909446.DvuYhMxLoT@rjwysocki.net
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dsmethod.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index e809c2aed78ae..a232746d150a7 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -483,6 +483,13 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
+	if (this_walk_state->num_operands < obj_desc->method.param_count) {
+		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
+			    acpi_ut_get_node_name(method_node)));
+
+		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+	}
+
 	/* Init for new method, possibly wait on method mutex */
 
 	status =
-- 
2.39.5




