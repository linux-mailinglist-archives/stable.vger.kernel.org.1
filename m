Return-Path: <stable+bounces-39322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B58A34FA
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 19:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC1D1C23D3A
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112F14D2B7;
	Fri, 12 Apr 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="b/jxgz+g"
X-Original-To: stable@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AB149009
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943643; cv=none; b=PNNe8VxavpcHAXlqyCUdHbZQeABVSlBMaZCuXpcGm25eJpOn4hg0a3kalVU5JVeFvH3OAddaoX2wDoeOktYSZ1W5S5aalvCv2RgrGCsArW2TdPsK+HZCdzzYrRp9Amop2lCDhCueNcre+0K+8T3QI6xxIZZ2illRUilkA9eq2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943643; c=relaxed/simple;
	bh=23l60EkZJtOww7eXwnZdIhLuqwuovHLySMexcJwpYaI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LbnEZbh+CVcpD/TifIxKZGn7n49vWkD8ohsYzNcp+cnfG9PaBYMD0p6gZj3Apt5Rtd0afT4wscQOqmaYdLeDyNYMMoe0y3mnzxA3q2h+NtKaAZico4EJJCQvHJaNpSWl85lafR0dVQhVjsjSe3c8oFY/CbGqUrYpgcCwRN3CO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=b/jxgz+g; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1712943219; bh=23l60EkZJtOww7eXwnZdIhLuqwuovHLySMexcJwpYaI=;
	h=Date:To:From:Subject:From;
	b=b/jxgz+gh/1HjUQSr9w9pbyM6OaLANTBVF6ViMM1h827dVbJKJOSHPluQJ3gjQjqE
	 318QOpTF0kIJEqnhgfvPaeuipXtOxwMcK+DEQqXTzy5q8iXmQdtOeycWJInmyhEnfZ
	 /JZEdVaMiu/R+mjG2Kb6NYvjKbC0mbLD0c41xeuY=
Received: from [172.22.111.213] (185.102.219.38.adsl.inet-telecom.org [185.102.219.38])
	by mail.ionic.de (Postfix) with ESMTPSA id 41FC91480C9F
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 19:33:39 +0200 (CEST)
Message-ID: <8fd3cf24-59da-4b91-a0b4-858d2b0916b5@ionic.de>
Date: Fri, 12 Apr 2024 19:33:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Mihai Moldovan <ionic@ionic.de>
Subject: 6.8.3+ panic at boot with CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
Autocrypt: addr=ionic@ionic.de; keydata=
 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
 PAt/5Rg+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KDQpTaW5jZSB5b3UgYmFja3BvcnRlZCA0MTA0NGI0MWFkMmM4YzgxNjVhNDJlYzZl
OWE0MDk2ODI2ZGNmMTUzIHRvIDYuOC4zIGFuZCANCmhpZ2hlciwgdGhlIGtlcm5lbCBjcmFz
aGVzIGhhcmQgb24gYm9vdCBpZiBCVFJGUydzIHNhbml0eSBjaGVja3MgaGF2ZSBiZWVuIA0K
ZW5hYmxlZCAoQ09ORklHX0JUUkZTX0ZTX1JVTl9TQU5JVFlfVEVTVFM9eSkuDQoNClBsZWFz
ZSBiYWNrcG9ydCBiMjEzNmNjMjg4ZmNlMmYyNGE5MmYzZDY1NjUzMWIyZDUwZWJlYzVhIHRv
IHRoZSBzdGFibGUvbWFpbmxpbmUgDQpzZXJpZXMgZml4IHRoaXMgaXNzdWUuDQoNCg0KQmVz
dCByZWdhcmRzDQoNCg0KDQpNaWhhaSBNb2xkb3Zhbg0K

