Return-Path: <stable+bounces-152924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F705ADD17C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8E317C276
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C1E2E9737;
	Tue, 17 Jun 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2kRlRnG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542782EF659;
	Tue, 17 Jun 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174282; cv=none; b=VeGpl7lIayUgPwVBGwqu7eceJWIMesyzaEB5ok/JNUbFLqmrdVufPXhG8gyq/SAMskbJyfxgyP8ieAXNLVMbEX9+XwZ8fW1AsE0aombsLDREyhhjeB9CNxwyQCKEN4Gtpimmr3xUy1MZjHmM76XdNzPApKiJ1FO6RAxurXF5z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174282; c=relaxed/simple;
	bh=JPtVLRULCN2MhFZL/EIKryFEwaiMrGMd6fsf3oJxTnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bjgpn+EqbrqpxNYVg2srOsSaExNTPsi+jaOeNHP2Ioyzpb0icTkcHOtPtYdLDNG3NZxgCuMePVe1CX5eNNUrgXdPoBLq+8XO49IQmGjzLNHr9sbnS16rG9i4L+jEz12mdAqQjhGR5hd5hAyYA3t5tsYv0OKjN+uoEprcLzbTf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I2kRlRnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B2C4CEE3;
	Tue, 17 Jun 2025 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174282;
	bh=JPtVLRULCN2MhFZL/EIKryFEwaiMrGMd6fsf3oJxTnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2kRlRnGA7/namp8JahN/MHf05DD3EkDusV4Cf/MLvNLMjBm5YLRYNqUW2G1cz2Fo
	 aOgfz6aHJg29VjA2H+X98TJq3hdd5Q9Wdj3vOc6wZmp2F+fD+igkR3rJmCADfIBb8x
	 0Bn0FoHREaDWJZrFT/panFiPJDz/rkjwASvirSUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/356] ACPICA: exserial: dont forget to handle FFixedHW opregions for reading
Date: Tue, 17 Jun 2025 17:22:33 +0200
Message-ID: <20250617152339.753263489@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

[ Upstream commit 0f8af0356a45547683a216e4921006a3c6a6d922 ]

The initial commit that introduced support for FFixedHW operation
regions did add a special case in the AcpiExReadSerialBus If, but
forgot to actually handle it inside the switch, so add the missing case
to prevent reads from failing with AE_AML_INVALID_SPACE_ID.

Link: https://github.com/acpica/acpica/pull/998
Fixes: ee64b827a9a ("ACPICA: Add support for FFH Opregion special context data")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Link: https://patch.msgid.link/20250401184312.599962-1-d-tatianin@yandex-team.ru
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/exserial.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 5241f4c01c765..89a4ac447a2be 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -201,6 +201,12 @@ acpi_ex_read_serial_bus(union acpi_operand_object *obj_desc,
 		function = ACPI_READ;
 		break;
 
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+
+		buffer_length = ACPI_FFH_INPUT_BUFFER_SIZE;
+		function = ACPI_READ;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
-- 
2.39.5




