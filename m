Return-Path: <stable+bounces-76991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA298457C
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB321C21975
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F31A4F36;
	Tue, 24 Sep 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUMI3jKA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC093C099;
	Tue, 24 Sep 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179563; cv=none; b=Lv31OJpDzUHGglk5tFjNtx9shksAxY/XyUIc52D2TW7wVYNBamxyqel/6IPJ3GUiipj2JZNYJsOHak0LBa/UZgfI47IcGHgL2X4NBsLS8l/E2iiXCOh+P7oUY84tml3T+4iqPxOmjI0dgIGxrc9ajSoalInbUGEpJVj6ss/MOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179563; c=relaxed/simple;
	bh=jBzztolWxxyRZbyW759j16y1GaCdbozTCQJIVGF6EcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hqdvR8E6+IdNe5SALNhatv615nlIRBBSmOIjdTnV+2hNx/CtpJJAYq1qs7clFThpWI/g5iq36XGOmWqL4ETJQF9xZJD2xDowx/46EZOFVP03knpe/ts0SRNU/Z+JjbvI3uJXxOs3mmSbhmeFOdr+2AwwOSjt5tTLPa1tRGTzeFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUMI3jKA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727179561; x=1758715561;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jBzztolWxxyRZbyW759j16y1GaCdbozTCQJIVGF6EcY=;
  b=gUMI3jKA9MicKA24TPRISC2J5eN0mKlkFsmLDv93Ozd8aC8vIHPS2PZI
   le+PbToxkULvfyk85FZ2GPcBVASasuA1wzKBnOZWB2M6aAY8fYp+GySxQ
   lXZdDp8MZAAPKLLMrd+imhm5PRhvfscr1EX2GRIZXILES8EJyggN5xCEr
   7roCPhG54NVYMUv//JWOz0uzRT368/V08qwAWUzG1Q7YtoGB46VNnuVXj
   DvsJTDD6vlgZS/62NkeEkoXr4jeyvcDAixq0bhId21sA8Lh745VIjdCMj
   U7a9JltlP0gHW1QMZ1IcDPXkKALsiu55W/CRFxVO7u1R/v+pQBSXqmRhR
   A==;
X-CSE-ConnectionGUID: wLXc7HxkTDmE3Ktg3R5b5A==
X-CSE-MsgGUID: a2ZS+4KzR9ap50m7VVgqzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43639108"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="43639108"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:06:00 -0700
X-CSE-ConnectionGUID: HTk05PvZTlGR1w7fN80MBw==
X-CSE-MsgGUID: gzyOwvxvTTWtIyv1JhkQ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71387986"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.183])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:05:55 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: George Rurikov <g.ryurikov@securitycode.ru>
Cc: George Rurikov <g.ryurikov@securitycode.ru>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm: Add check for encoder in intel_get_crtc_new_encoder()
In-Reply-To: <20240924114004.1084283-1-g.ryurikov@securitycode.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240924114004.1084283-1-g.ryurikov@securitycode.ru>
Date: Tue, 24 Sep 2024 15:05:51 +0300
Message-ID: <87tte545pc.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVHVlLCAyNCBTZXAgMjAyNCwgR2VvcmdlIFJ1cmlrb3YgPGcucnl1cmlrb3ZAc2VjdXJpdHlj
b2RlLnJ1PiB3cm90ZToNCj4gSWYgdGhlIHZpZGVvIGNhcmQgZHJpdmVyIGNvdWxkIG5vdCBmaW5k
IHRoZSBjb25uZWN0b3IgYXNzaWduZWQgdG8gdGhlDQo+IGN1cnJlbnQgdmlkZW8gY29udHJvbGxl
ciwgb3IgaWYgdGhlIGhhcmR3YXJlIHN0YXR1cyBoYXMgY2hhbmdlZCBzbyB0aGF0DQo+IGEgcHJl
LWV4aXN0aW5nIGNvbm5lY3RvciBpcyBubyBsb25nZXIgYWN0aXZlLCBub25lIG9mIHRoZSBzdGF0
ZQ0KPiBjb25uZWN0b3JzIHdpbGwgbWVldCB0aGUgYXNzaWdubWVudCBjcml0ZXJpYSBmb3IgdGhl
IGN1cnJlbnQgY3J0YyB2aWRlbw0KPiBjb250cm9sbGVyLg0KPg0KPiBJbiB0aGUgZHJtX1dBUk4g
ZnVuY3Rpb24sIGVuY29kZXItPmJhc2UuZGV2IGlzIGNhbGxlZCwgc28NCj4gJyZlbmNvZGVyLT5i
YXNlLmRldicgd2lsbCBiZSBkZXJlZmVyZW5jZWQgc2luY2UgZW5jb2RlciB3aWxsIHN0aWxsIGJl
DQo+IGluaXRpYWxpemVkIE5VTEwuDQoNCmVuY29kZXIgaXMgbm90IGRlcmVmZXJlbmNlZCB0aGVy
ZS4NCg0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcu
b3JnKSB3aXRoIFNWQUNFLg0KPg0KPiBGaXhlczogZTEyZDYyMThmZGEyICgiZHJtL2k5MTU6IFJl
ZHVjZSBiaWdqb2luZXIgc3BlY2lhbCBjYXNpbmciKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBHZW9yZ2UgUnVyaWtvdiA8Zy5yeXVyaWtvdkBzZWN1cml0
eWNvZGUucnU+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9k
aXNwbGF5LmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9k
aXNwbGF5LmMNCj4gaW5kZXggYjRlZjRkNTlkYTFhLi4xZjI1YjEyZTVmNjcgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGlzcGxheS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGlzcGxheS5jDQo+IEBAIC04MTks
OSArODE5LDExIEBAIGludGVsX2dldF9jcnRjX25ld19lbmNvZGVyKGNvbnN0IHN0cnVjdCBpbnRl
bF9hdG9taWNfc3RhdGUgKnN0YXRlLA0KPiAgICAgICAgICAgICAgICAgbnVtX2VuY29kZXJzKys7
DQo+ICAgICAgICAgfQ0KPg0KPiAtICAgICAgIGRybV9XQVJOKHN0YXRlLT5iYXNlLmRldiwgbnVt
X2VuY29kZXJzICE9IDEsDQo+ICsgICAgICAgaWYgKGVuY29kZXIpIHsNCj4gKyAgICAgICAgICAg
ICAgIGRybV9XQVJOKHN0YXRlLT5iYXNlLmRldiwgbnVtX2VuY29kZXJzICE9IDEsDQo+ICAgICAg
ICAgICAgICAgICAgIiVkIGVuY29kZXJzIGZvciBwaXBlICVjXG4iLA0KPiAgICAgICAgICAgICAg
ICAgIG51bV9lbmNvZGVycywgcGlwZV9uYW1lKHByaW1hcnlfY3J0Yy0+cGlwZSkpOw0KPiArICAg
ICAgIH0NCj4NCj4gICAgICAgICByZXR1cm4gZW5jb2RlcjsNCj4gIH0NCj4gLS0NCj4gMi4zNC4x
DQo+DQo+INCX0LDRj9Cy0LvQtdC90LjQtSDQviDQutC+0L3RhNC40LTQtdC90YbQuNCw0LvRjNC9
0L7RgdGC0LgNCj4NCj4g0JTQsNC90L3QvtC1INGN0LvQtdC60YLRgNC+0L3QvdC+0LUg0L/QuNGB
0YzQvNC+INC4INC70Y7QsdGL0LUg0L/RgNC40LvQvtC20LXQvdC40Y8g0Log0L3QtdC80YMg0Y/Q
stC70Y/RjtGC0YHRjyDQutC+0L3RhNC40LTQtdC90YbQuNCw0LvRjNC90YvQvNC4INC4INC/0YDQ
tdC00L3QsNC30L3QsNGH0LXQvdGLINC40YHQutC70Y7Rh9C40YLQtdC70YzQvdC+INC00LvRjyDQ
sNC00YDQtdGB0LDRgtCwLiDQldGB0LvQuCDQktGLINC90LUg0Y/QstC70Y/QtdGC0LXRgdGMINCw
0LTRgNC10YHQsNGC0L7QvCDQtNCw0L3QvdC+0LPQviDQv9C40YHRjNC80LAsINC/0L7QttCw0LvR
g9C50YHRgtCwLCDRg9Cy0LXQtNC+0LzQuNGC0LUg0L3QtdC80LXQtNC70LXQvdC90L4g0L7RgtC/
0YDQsNCy0LjRgtC10LvRjywg0L3QtSDRgNCw0YHQutGA0YvQstCw0LnRgtC1INGB0L7QtNC10YDQ
ttCw0L3QuNC1INC00YDRg9Cz0LjQvCDQu9C40YbQsNC8LCDQvdC1INC40YHQv9C+0LvRjNC30YPQ
udGC0LUg0LXQs9C+INCyINC60LDQutC40YUt0LvQuNCx0L4g0YbQtdC70Y/RhSwg0L3QtSDRhdGA
0LDQvdC40YLQtSDQuCDQvdC1INC60L7Qv9C40YDRg9C50YLQtSDQuNC90YTQvtGA0LzQsNGG0LjR
jiDQu9GO0LHRi9C8INGB0L/QvtGB0L7QsdC+0LwuDQoNClNvcnJ5LCB3ZSBjYW4ndCBhY2NlcHQg
cGF0Y2hlcyB3aXRoIHRoYXQgYm9pbGVycGxhdGUgYW55d2F5Lg0KDQpCUiwNCkphbmkuDQoNCg0K
LS0gDQpKYW5pIE5pa3VsYSwgSW50ZWwNCg==

