Return-Path: <stable+bounces-247693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CvoAqgPB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:20:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE754F5B4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B624311F393
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948EB47D952;
	Fri, 15 May 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQ+dAcLJ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414247D930
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845585; cv=none; b=aD0ucJkBX7WSPb7iagNjOl/x6qdosHfljpkmmo1XRWEg1g0V3hLDm9kUoVaILy07nDm8+8lLT7pi2ueOL2939oy3IBFY2PM841g8MgwQYpbCch4gE89YtlwxP8ep0dS2dMU/cwQTBbpPgW7fmLap71vcnWqdsZWPnus7NuKWH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845585; c=relaxed/simple;
	bh=Fkp3yswg9gYFfFP3GiYCsWGevpIX6W2PfOvSwjsaIcw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=cpM19aGZhOt1ec2j+MKNhn3kXL5+ptlJ48oBneLGkoY/zbaR97pFtzPlJZO5St+v7soCPdaKvJ+KRQphV7lBw/8iua0eKmr+slGesG9zOTmHznAhUH6XFGppNhaDnfJVKUhlUNqSsSduWtK7w6zvrGFMrIiGkPtEnyALtzYl3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQ+dAcLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F39C2BCB0;
	Fri, 15 May 2026 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845584;
	bh=Fkp3yswg9gYFfFP3GiYCsWGevpIX6W2PfOvSwjsaIcw=;
	h=Subject:To:From:Date:From;
	b=XQ+dAcLJYKE5nk1BkH6AaqpeBEBi9l/Cv4olI85+qcspZxAVLgMa+ahTLXJwJB6F4
	 bcJ9JbS/VeWqLei94O1SLO8Omwn0D3lBO0cgdwlL9WK4beSMzqRteS49X33vxRL2X3
	 F7cZfoldUEUZBb4PeeAvNqXSlqFy3uXWeu+sUu/g=
Subject: patch "iio: magnetometer: st_magn: fix default DRDY pin selection for" added to char-misc-linus
To: advaitd@mechasystems.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:57 +0200
Message-ID: <2026051557-tinwork-overdrive-b30c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7ADE754F5B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247693-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,mechasystems.com:email]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: st_magn: fix default DRDY pin selection for

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 49f79cd28f1e3333cbe0d616ce59ead0b24bf34e Mon Sep 17 00:00:00 2001
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Tue, 7 Apr 2026 12:50:59 +0530
Subject: iio: magnetometer: st_magn: fix default DRDY pin selection for
 LIS2MDL

The device tree binding for st,lis2mdl does not support
st,drdy-int-pin property. However, when no platform data is provided
and the property is absent, the driver falls back to default_magn_pdata
which hardcodes drdy_int_pin = 2. This causes
`st_sensors_set_drdy_int_pin` to fail with -EINVAL because the LIS2MDL
sensor settings have no INT2 DRDY mask defined.

Fix this by checking the sensor's INT2 DRDY mask availability at
probe time and selecting the appropriate default pin. Sensors that
do not support INT2 DRDY will default to INT1, while all others
retain the existing default of INT2.

Fixes: 38934daf7b5c ("iio: magnetometer: st_magn: Provide default platform data")
Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/magnetometer/st_magn_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index ef348d316c00..7644bd04654b 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -506,6 +506,11 @@ static const struct st_sensors_platform_data default_magn_pdata = {
 	.drdy_int_pin = 2,
 };
 
+/* LIS2MDL only supports DRDY on INT1 */
+static const struct st_sensors_platform_data alt_magn_pdata = {
+	.drdy_int_pin = 1,
+};
+
 static int st_magn_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -628,8 +633,12 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!pdata)
-		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+	if (!pdata) {
+		if (mdata->sensor_settings->drdy_irq.int2.mask)
+			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+		else
+			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
+	}
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-- 
2.54.0



