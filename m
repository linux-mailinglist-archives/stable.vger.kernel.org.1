Return-Path: <stable+bounces-179195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68657B51613
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDD8467C03
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853482877F7;
	Wed, 10 Sep 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9gURqIr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FB27E7EB
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504872; cv=none; b=gzdmZqIMrY5AW4fOQBVf22FD1ptaApbAxtaSafuEmvvvm4uDPsqmaDaR2BxMk33cXUOFV3AwU61fTR0WU0/TInbYiKhhjUZKXuqINsgICyQbiAmLnBd8UDqJ8Twbo6OVLSRXU9K3RkeLhuYfFWnYWTz4HTwELEEy/oopxfGzkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504872; c=relaxed/simple;
	bh=WbEtV0CPIKyH7FQXM3VCsQudJJTxDRA8dDx1E0cAO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gsxq11dsDzoBkuxLM/tQ7eLea/FiA3BeAkS6uScNA7lSDx/+dVOwNTMCNK2PGx6EnxkQRER+s4Eek27eHJFyy+hqhpLyn7k9tyTZ62GVGr0Nl1+6ZV+PiMDp4j3UtVsxRBX1xEZBDtnBxw+GgaLwDeooArtca3g9rVichFkVCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9gURqIr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dea538b826so5644262f8f.2
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757504867; x=1758109667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wg2Ph+PhoATIteAbw+PWkWD/06VwBl1ynTVTQY5RYgk=;
        b=O9gURqIr9IXa2PiraV3ZG7m/kA7qet5iK0WosCDX5sreMI53xvu9CX5pcAKsHD6lss
         IhfW0/1izzHtY72t1Bakxg5sr0satsgbo2Zx1JJALWxvbRuUcj3niVR954LQZxrioBAI
         K5AD3d8tH0DNixG6vQ1LT8hUmCtMONWUtbbEQF9j4bitVo3mo/hEJIQlubqB4Jbm0umu
         onyV8Buze+gqHxcl4qABdDLoa5zsxboHn8O74UUk7G7FpELaIYDoNlcG2tUzfe7145fB
         6seaVpf0EUW6i5c523mYuFUwUQb46rKiCARkFu/uSZyn5zXU09/93xiq4MD43ART4Luk
         hTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504867; x=1758109667;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg2Ph+PhoATIteAbw+PWkWD/06VwBl1ynTVTQY5RYgk=;
        b=EbUeMpR37MOU3A9IUCWe1Kk8xE0BRROmJN5Vunoko1kivhRpH8LmfQRGZTtk1PjB4O
         S4dkruqMPm0u9X07yTEYTLzalvaszQ8LykoH2NnnP+N2R8cGHH+xsb9ANSlV338xIjCP
         /oyJsroM1q2GR7h8+2oueN0ZuH1l16Fz7aXssXvn4RHiyDJX46Dss1bHDezCJdMC7TiS
         bfSnh89CqYCYgAzc6IdaZZk7RgItDG6+siewRXjarGElruAZaFJOgLyNoBS0CSslhRIR
         1Qx3IbweOOZY+N932Z1/+cdftK473S30VUNF3J3bdgQu2tsuRwETec+e7wMTtxrG1yAq
         u+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcjn0zBZUiXhdNTpR2fb59fHfSfsa74IiAHphqxbhDzdCq0pk22MrvS/TFJ6GR4HkOk/LWe2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UsNyNqRyKPYmLUvazQU6UcV8jiVUBgByosiSfG3aXovsC5PT
	c5F5OPKdlUdpfmwojOYYPtjepw9SoMjBJlhvW8rJze2bN5XQms6ABXnYSkQUBZZqalI=
X-Gm-Gg: ASbGnctMt7R2f556BD0VdGVKFd0vS4dgheZgY2no3EdoExjzTyKPgHh7cS89u+LWRXU
	83IqjfwwxsuLtXyYQVu7u8Li75q9O/lBwEWbbaTDaXM0X4v5l3PZjyc2b+wjKdNQuj1WGrXIkou
	FtpPuB0hOGzXT4YloIkcXdTc7w9hl63oaSRB9jjmhGmj0sD8rEYKU6/Yij+WWACePaHOPXEcUen
	ds4cnlfSeg4VtvCGRdUaR6tPpSpy7gx+vNahNfezvrawDStSIdX6+UoI4uCx87X+g5UNmcElJsZ
	KAqifndZ8/y3KqKoWp8Mp9UybtRECE4IYUriniZ/nwvS4PTjhA67PWasxl/K7vV7UkU+/mnFlRW
	jXAT6xp6bWZutoqULO1E3C+hCwXU=
X-Google-Smtp-Source: AGHT+IHpMaxaSaJ4cnLK/bK8wa1YrfXhxVJLuuDTkuh1vmaIEZ84Pcyd9YYbH8IfZoLQCxj9xtJuUA==
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr7821201f8f.55.1757504867368;
        Wed, 10 Sep 2025 04:47:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521bfe00sm6893713f8f.5.2025.09.10.04.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:47:46 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:47:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, GuangFei Luo <luogf2025@163.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	luogf2025@163.com
Subject: Re: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
Message-ID: <202509101620.yI0HZ5gT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907035154.223983-1-luogf2025@163.com>

Hi GuangFei,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/GuangFei-Luo/ACPI-battery-prevent-sysfs_add_battery-re-entry-on-rapid-events/20250907-115505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250907035154.223983-1-luogf2025%40163.com
patch subject: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
config: x86_64-randconfig-161-20250909 (https://download.01.org/0day-ci/archive/20250910/202509101620.yI0HZ5gT-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509101620.yI0HZ5gT-lkp@intel.com/

smatch warnings:
drivers/acpi/battery.c:1046 acpi_battery_update() warn: inconsistent returns '&battery->sysfs_lock'.

vim +1046 drivers/acpi/battery.c

9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1001  static int acpi_battery_update(struct acpi_battery *battery, bool resume)
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1002  {
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1003  	int result = acpi_battery_get_status(battery);
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1004  
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1005  	if (result)
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1006  		return result;
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1007  
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1008  	if (!acpi_battery_present(battery)) {
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1009  		sysfs_remove_battery(battery);
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1010  		battery->update_time = 0;
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1011  		return 0;
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1012  	}
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1013  
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1014  	if (resume)
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1015  		return 0;
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1016  
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1017  	if (!battery->update_time) {
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1018  		result = acpi_battery_get_info(battery);
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1019  		if (result)
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1020  			return result;
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1021  		acpi_battery_init_alarm(battery);
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1022  	}
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1023  
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1024  	result = acpi_battery_get_state(battery);
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1025  	if (result)
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1026  		return result;
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1027  	acpi_battery_quirks(battery);
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1028  
ce5e61beaad5c5a GuangFei Luo            2025-09-07  1029  	mutex_lock(&battery->sysfs_lock);
297d716f6260cc9 Krzysztof Kozlowski     2015-03-12  1030  	if (!battery->bat) {
eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1031  		result = sysfs_add_battery(battery);
eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1032  		if (result)
eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1033  			return result;

mutex_unlock(&battery->sysfs_lock) before returning.

eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1034  	}
ce5e61beaad5c5a GuangFei Luo            2025-09-07  1035  	mutex_unlock(&battery->sysfs_lock);
e0d1f09e311fafa Zhang Rui               2014-05-28  1036  
e0d1f09e311fafa Zhang Rui               2014-05-28  1037  	/*
e0d1f09e311fafa Zhang Rui               2014-05-28  1038  	 * Wakeup the system if battery is critical low
e0d1f09e311fafa Zhang Rui               2014-05-28  1039  	 * or lower than the alarm level
e0d1f09e311fafa Zhang Rui               2014-05-28  1040  	 */
e0d1f09e311fafa Zhang Rui               2014-05-28  1041  	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
e0d1f09e311fafa Zhang Rui               2014-05-28  1042  	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
e0d1f09e311fafa Zhang Rui               2014-05-28  1043  	     (battery->capacity_now <= battery->alarm)))
33e4f80ee69b516 Rafael J. Wysocki       2017-06-12  1044  		acpi_pm_wakeup_event(&battery->device->dev);
e0d1f09e311fafa Zhang Rui               2014-05-28  1045  
557d58687dcdee6 Zhang Rui               2010-10-22 @1046  	return result;
4bd35cdb1e2d1a1 Vladimir Lebedev        2007-02-10  1047  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


