Return-Path: <stable+bounces-187881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD84BEE279
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 11:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BB7189D19A
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED82E03F9;
	Sun, 19 Oct 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM5Bfmmd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A67E792
	for <stable@vger.kernel.org>; Sun, 19 Oct 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760867507; cv=none; b=BW11dyIi2JroOmOTClhKS8+gMopREdupiFVcvplGjCGrdh8d7+zO7p/gdSOiEFlH0OqNPR2UjKfkQLL77Tp/4J9W3kbQLnZAZc+TsuWuvh0GR/2Zo8knvRuSDjnJvEQwpd3ZZsuserqo4a6ZLiVrDMU988jC1Mmu+ml78XDWuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760867507; c=relaxed/simple;
	bh=StQ6hiSS/ddwlsO576uA8gheOyDnzmZgNCzeCn8v2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUEPd+zgDLb6POMn/ff+1D3FYAWGZddy5A7JDbJ96GAOaws2TGmOQxAQboQAiL7A3DCY+xncF4chMXJ28TrM8Omk9QexnP0nA+aKXZR3/VS5bTZMELTnUTQEXttkECPENlFgWdBHUXUTr/KzFPuitGOBBde+uQcAfdSDALxRm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM5Bfmmd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-58affa66f2bso4130470e87.1
        for <stable@vger.kernel.org>; Sun, 19 Oct 2025 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760867504; x=1761472304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+DYglWBDI71zz/BrQNEMs/n8cMj7C4w9i31aDwg9uA=;
        b=YM5BfmmdTm2crHm8SpTJyauU9zRwRagmBQqLeWCceklsUcmzPE0Vr8Vc73lg9AFwNo
         pVwccn2jPjXAcWv+7hiZEbCsQ1yjk8WPGUROnB+wtjp4QSCDAwRR9x+Iw7gS6T+bpFC8
         9iFmRizSQFiA1ydoffF7E72BmmTEhlV8XeBGI6d6A35wSYGWIYuILCOe1/x8nH7cr8io
         UggGwrzmlCftW1nYXTuUp8z9opLhGwh6gJLVjYj7uAqHc7eCSFzX3GVE94+g4uyCUFrG
         XjsUOYh41RyNAVsulpIdALjzALEGGk7/fs9fm0ZPMGsR2G7apU3nzMw2bN+jf7zEew87
         wQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760867504; x=1761472304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+DYglWBDI71zz/BrQNEMs/n8cMj7C4w9i31aDwg9uA=;
        b=s4S761SA6TlyYlqiIoAt8JkvGc3rutgp/nZLst6GPITQTGBozeOmFZh2goQliHaTDP
         26bfq2YqPq8WcQWzIDdnyaPzzejHbHUo9k3iIimrausPjTBaL65bH3H/Y5QmCMLcRW6L
         yYXAl+bhHKUXsTCqVJUF1j0UbbN2TiVnDBkya39mjZrs+Pw2SjkGeT6TQk9+oH7xUdGk
         TqQwqQM/MiLkDTkeH3PaWKiQGHp9odGIwKFBnAKap0VXhKpcTAbsD2RSPyuQQxign1Fg
         ifM84I1BsomBGdaAomU8U99ENLC7NSClomCOh48lHBvXwyYASdYsuqBVwORZg3PjS63V
         60Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVm79GPM/dRIlAI0sDRa3D5E8koi3BDiOFyuVZuAjXJXLEAk4ZXawZtUGMN9TfVpETYnNSbpx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmIJaSS6J6M6TQCDbzIFSDTfyPvQwyZcF4fJwJMNy5pL1JpyK
	iv0ZvlP6QyIcR5VPLNS7xbyf5pXrWudDsgWoo4Dywok95CNn7p6Gy/Sc
X-Gm-Gg: ASbGncu446KwcyS4MP5hSAGoGtoBTNrnngWEXtYr8zlyBTAP9fyWQgnJVuuWza6jlvD
	9jpbm7qYF7yrKbvu6sOvpSIT+Od6ubxQzGz9YtUMWak+nVlxIiaJlvfPNACzqCeHP8kgDpfJva9
	4ydpvZSTWkqDjnxaW6E2TmpN1pySOlC37i/d+zWG05cF4M2MUfoME+MAoBUDFZKmIXXn74YlXnc
	RBzU5SeFFKk02e/SeaRHv/eEyATSJdTu9BZIhP8IqFrpHfRHncvC6cDCR4fd1XhY762o5cHTx0M
	yjwqSHILCplAxMfRHZDWSxkt/RG6DtIt7cmbVTyJsn5obXWC6kTWzvts+IxvjnyVmV8mNSiK7Ny
	Y0HCxhwFlrDSO1kE+aXgWB5HDQmQQn/HZXWyB4kqCVjbNlBFhMqdzQxbsqFjQS1eZLLvMuv4iOL
	46
X-Google-Smtp-Source: AGHT+IEk7oK3CvYkCqvLOZMVwW2h+hwBO81K6lyYByY9eQ+fsQlUxRuRCe5/anMAeziBgkE5R5Avug==
X-Received: by 2002:a05:6512:39c2:b0:591:d120:1094 with SMTP id 2adb3069b0e04-591d8577799mr2641550e87.33.1760867503501;
        Sun, 19 Oct 2025 02:51:43 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf49bsm1425739e87.28.2025.10.19.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 02:51:42 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: a.shimko.dev@gmail.com,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	p.zabel@pengutronix.de,
	stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250_dw: handle reset control deassert error
Date: Sun, 19 Oct 2025 12:51:31 +0300
Message-ID: <20251019095131.252848-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025101902-puritan-thrift-b2d4@gregkh>
References: <2025101902-puritan-thrift-b2d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Cc: stable@vger.kernel.org
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi,

Done.

Thank you!

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009081309.2021600-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * https://lore.kernel.org/all/20251019085325.250657-1-a.shimko.dev@gmail.com/
  v3:
  	* Add Cc: stable@vger.kernel.org

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.43.0


