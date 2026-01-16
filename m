Return-Path: <stable+bounces-210049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87AD31CD8
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7789730D5A18
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE752265CA8;
	Fri, 16 Jan 2026 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbzIsiTi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C691258EE0
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569884; cv=none; b=dknH9DMxvjOWIKIEcG2h8RFpy7Efmoi51kKYOfWg48Z1prePjEG5VDohN4jT7654/c8O21rMImzYT/ZK/4IqEC09vjti3+oC65uzqOSH+QVaOr5qsBDuBwGrRfrfhGOb1Nrfh7Adm9veNExMJsaPnhkU/gbrLl4yyQ0PrU9VLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569884; c=relaxed/simple;
	bh=5/BOHiJVlAIIj9Ft1n94EaDNmmyW4A7EG9Skfl9jGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oa7htxgwyOrKJ3+UM3QWo/2oa/OHyjBbx9G+nh+cFdt9terhesM9eRKkSjM3ZZMRW/HMzF3KOLPjC9ffsaxhPTv1HP8OtO1Ig7MTdcxUucFgmxi8r+1+5arqjMPX1xrfcob0I8PIMUjQSgmMC0ukgGxYB1NEvnAfwrqtabPUFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbzIsiTi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee974e230so18290335e9.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 05:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768569881; x=1769174681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5/BOHiJVlAIIj9Ft1n94EaDNmmyW4A7EG9Skfl9jGNg=;
        b=JbzIsiTiqZFUi1c6Uedg62vCW/lzJDrGF3NZ+Eo9/dhpj4dT5WvoK3DQQx3v2Mn9Z/
         qcnV0kxN/flBfqin30BLBdJ46/bgvAWZ81S5xfiw2jwk48RCrZLF5tpmJYHGOS+iBqdQ
         8nDAu9tBQAkD6TB7OjRaP9dfJvkphVxQc5TkKwn6W7B7Ewx/d1IUo2QbiCqFTJQl/x2Y
         KHagy30EIS2BTZRF//MEcjbsLQTEFK9fDQ5vLfAPbFtghSARPkDZ7HpcyjcE62qc8A3K
         FwzoZCYLAJrpsLEol9y245af8SzjjRlUnADKrwr+3k5SzXOM4iP1u29SeEe9PdXKYS34
         VBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569881; x=1769174681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/BOHiJVlAIIj9Ft1n94EaDNmmyW4A7EG9Skfl9jGNg=;
        b=sLIFmdf/F3T39Eulh8cewTRR/99Y75TMgwYzd8dt1vZvwaxiScusw6MbiOSJbfIFoe
         9HPl6QVe2lz+tvTcQVwWbeOUNWiX4JO/5/CxBM3ogY2XtGgqFRkMj9haeVZB3rDfiQ+P
         42CJ5GElB82jZO5lv89ffAYpCEFk1rvRjS6ez6TIkqQPFrrK9rhMUQ+WnKwbZCqeMqJo
         P92dY/T7D5X0GrY31dZtlrUDl61aG2CCQOpjZwFZvRKYSXt3k8eeEszOGF/W4MNNn7dQ
         lslQ/yyzc//Tmr726sq9LJ9bX1EafWkOzz/n4qOAFaSpi9cEHpCYWQi8xfrZzYH5KgWG
         OTrg==
X-Gm-Message-State: AOJu0YzreVTY3d8k98ntJtSZekWS/dOTXbowD8hVI+3j+BP8D4QvglLE
	Y/KjV2dNCmiYq5UfeErsrkVstf6zAv7wrH7b2VnyvOgNkECCkzZ8qVaS
X-Gm-Gg: AY/fxX6xfQV0WS0WUAD/vljhSGwr7sFUlh6D+6PBO1vvummi2d4avPQIa6yjgVuGiP3
	WpZenCJU5QEXgm53jlklDyW2udcyHOC1awfJMrf3iZlhO8M4pm6BfqlxGmSV1D5O6uPHJZ6aXyY
	W0izL1a1wyacszeIE9mcol3NxbtymFocKHeAV+NDunuqyKENvHjajJ5ABjF1YSE0OEl/558SrmO
	NK8Olr8fiLl/RErtx/GB36Vw1JnegzMV7Z1qEBm/h5rUeuXZ74yKsx/gt8g/ICDlCJoP34lDRiJ
	psyZIDMNzOBnjmomOYOhbYv3fKvzseQc0njJ6zxAVCuHhgKEwqlIiOu02QGq6Jr7jluWOPVwnyj
	/UhH5FaH2PuSOGe77AqJTiBSts7ie77+1lcm1as14sYmpLjzFRuWdwm2ETHoL0P0f9lLhXYO4kn
	TwxuHbQuAZ6iSIYTrgoeWdSlCtw0QA3k2i8p3MGXg4KsLX
X-Received: by 2002:a05:600c:3ba6:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-4801e2f3013mr36677445e9.3.1768569881304;
        Fri, 16 Jan 2026 05:24:41 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm97537275e9.10.2026.01.16.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:24:40 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5C428BE2EE7; Fri, 16 Jan 2026 14:24:39 +0100 (CET)
Date: Fri, 16 Jan 2026 14:24:39 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Sam Halliday <sam.halliday@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, 1122193@bugs.debian.org
Subject: Please apply commit f28beb69c515 ("HID: usbhid: paper over wrong
 bNumDescriptor field") to down at least 6.12.y
Message-ID: <aWo8F_XxsfmmpAYz@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear stable maintainers and Benjamin,

Back on beginning of december Sam Halliday reported an issue with ZWO
EFWmini in Debian (https://bugs.debian.org/1122193) which got reported
in https://lore.kernel.org/linux-usb/aT7TPAInuBOXctEZ@eldamar.lan/ and
subsequently fixed by Benjamin with f28beb69c515 ("HID: usbhid: paper
over wrong bNumDescriptor field").

The fix landed in 6.19-rc5, can you pick it please as well for stable
series, at least down to 6.12.y (but not checked for older ones, maybe
Benjamin can confirm until to which stable series it should go).

Thanks in advance,
Regards,
Salvatore

